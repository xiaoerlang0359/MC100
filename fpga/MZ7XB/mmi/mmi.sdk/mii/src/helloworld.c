/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "eeprom.h"

#define MII_CTRL0 0x43c00510
#define MII_CTRL1 0x43c00511
#define MII_PHYAD 0x43c00512
#define MII_REGAD 0x43c00513
#define MII_DATA0 0x43c00514
#define MII_DATA1 0x43c00515
#define GPIO_OUTPUT 0x41200000
#define GPIO_INPUT 0x41200008
#define PDI_CTRL 0x43c20502
#define PDI_STAT 0x43c20503
#define PDI_ADDR 0x43c20504
#define PDI_DATA 0x43c20508
#define ECAT_CTRL 0x43c10502
#define ECAT_STAT 0x43c10503
#define ECAT_ADDR 0x43c10504
#define ECAT_DATA 0x43c10508
#define ESC_EEPROM_ERROR_MASK 0x78
#define ESC_EEPROM_ERROR_CRC 0x08
#define ESC_EEPROM_SIZE 0x1000
#define ESC_EEPROM_ERROR_CMD_ACK 0x20

volatile uint32_t* gpio_ptr;
volatile uint8_t* eeprom_ptr;

void eth_ini(){
	volatile uint8_t *p;

	p = (uint8_t *)MII_CTRL0;
	*p = 9;
	p = (uint8_t *)MII_CTRL1;
	*p = 2;
	p = (uint8_t *)MII_PHYAD;
	*p = 129;
	p = (uint8_t *)MII_REGAD;
	*p = 0;
	p = (uint8_t *)MII_DATA0;
	*p = 0;
	p = (uint8_t *)MII_DATA1;
	*p = 33;
}
void eeprom_app(){
	uint8_t eeprom_reg;
	uint32_t eeprom_addr;
	eeprom_ptr = (uint8_t*)PDI_STAT;
	eeprom_reg = *eeprom_ptr;
	eeprom_ptr = (uint8_t*)PDI_ADDR;
	eeprom_addr = *eeprom_ptr;
	eeprom_addr = ((*(eeprom_ptr+1))<<8) | eeprom_addr;
	eeprom_addr = eeprom_addr<<1;
	eeprom_reg &= ~(ESC_EEPROM_ERROR_MASK & ~ESC_EEPROM_ERROR_CRC);
	if ((eeprom_reg & 0x07)==1){
		if (eeprom_addr < ESC_EEPROM_SIZE) {
			eeprom_ptr = (uint8_t*)PDI_DATA;
			for (int i=0;i<8;i++)
				*(eeprom_ptr+i) = aEepromData[eeprom_addr+i];
		}else{
			eeprom_reg |= ESC_EEPROM_ERROR_CMD_ACK;
		}
	}
	if ((eeprom_reg &0x07)==2){
		if (eeprom_addr < ESC_EEPROM_SIZE){
			eeprom_ptr = (uint8_t*)PDI_DATA;
			aEepromData[eeprom_addr] = *eeprom_ptr;
			aEepromData[eeprom_addr+1] = *(eeprom_ptr+1);
		}else{
			eeprom_reg |= ESC_EEPROM_ERROR_CMD_ACK;
		}
	}
	if ((eeprom_reg & 0x07)==4){
		eeprom_reg &= ~ESC_EEPROM_ERROR_MASK;
		eeprom_ptr = (uint8_t*)PDI_DATA;
		for (int i=0;i<8;i++)
			*(eeprom_ptr+i) = aEepromData[i];
		eeprom_ptr = (uint8_t*)PDI_STAT;
		*eeprom_ptr = eeprom_reg;
		eeprom_ptr = PDI_DATA;
		for (int i=0;i<8;i++)
			*(eeprom_ptr+i) = aEepromData[i+8];
	}
	eeprom_ptr = (uint8_t*)PDI_STAT;
	*eeprom_ptr = eeprom_reg;
}

void write_cmd(){
	eeprom_ptr = (uint8_t*)ECAT_ADDR;
	*eeprom_ptr = 0x08;
	eeprom_ptr = (uint8_t*)ECAT_DATA;
	*eeprom_ptr = 0x00;
	*(eeprom_ptr+1) = 0x01;
	eeprom_ptr = (uint8_t*)ECAT_CTRL;
	*eeprom_ptr = 0x01;
	eeprom_ptr = (uint8_t*)ECAT_STAT;
	*eeprom_ptr = 0x02;
	gpio_ptr = (uint32_t*)GPIO_OUTPUT;
	*gpio_ptr = 0x01;
	gpio_ptr = (uint32_t*)GPIO_INPUT;
}

void read_cmd(){
	eeprom_ptr = (uint8_t*)ECAT_ADDR;
	*eeprom_ptr = 0x08;
	eeprom_ptr = (uint8_t*)ECAT_STAT;
	*eeprom_ptr = 0x01;
	gpio_ptr = (uint32_t*)GPIO_OUTPUT;
	*gpio_ptr = 0x01;
	gpio_ptr = (uint32_t*)GPIO_INPUT;
}

void reload_cmd(){
	eeprom_ptr = (uint8_t*)ECAT_STAT;
	*eeprom_ptr = 0x04;
	gpio_ptr = (uint32_t*)GPIO_OUTPUT;
	*gpio_ptr = 0x01;
	gpio_ptr = (uint32_t*)GPIO_INPUT;
}

int main()
{
	uint16_t count;
    init_platform();
    gpio_ptr = (uint32_t*)GPIO_OUTPUT;
    *gpio_ptr = 0x01;
    gpio_ptr = (uint32_t*) GPIO_INPUT;
    while(1){
    	if (((*gpio_ptr) & 0x01) == 0x01){
    		eeprom_app();
    	}
    	count++;
    	if (count==0){
    		write_cmd();
    	}
    	if (count==32767)
    		read_cmd();
    	if (count==40000)
    		reload_cmd();
    }

    cleanup_platform();
    return 0;
}
