From: jklaas@comcast.net (James Klaas)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: smart battery
Message-Id: <marc-lm-sensors-117499240406443@msgid-missing>
List-Id: <lm-sensors.vger.kernel.org>
References: <marc-lm-sensors-117499240406438@msgid-missing>
In-Reply-To: <marc-lm-sensors-117499240406438@msgid-missing>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't know if the code should be inlined or attached.  I've attached it,
and I would be happy to resend inlined instead.  I would also be very
happy to test any drivers as needed.


On Thu, 5 Sep 2002, Mark D. Studebaker wrote:

> we don't know much about 'smart batteries' but
> the smart battery people were the original authors of the SMBus spec.
> There are some smart battery specs on the web too -
> it may be that the interface is standard.
>
> We'd love to see the GPL code. If anybody would like to write a driver
> then we will have the code to give them.
>
> mds
>
>
>
> James Klaas wrote:
> >
> > I hope this is the right place to post this.
> >

			James Klaas
-------------- next part --------------
/* battery.c
   Copyright (C) 2000 Linuxcare, Inc. 

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307, USA.  */

# include <sys/ioctl.h>
# include <fcntl.h>
# include <unistd.h>
#include <errno.h>

#include <linux/i2c-dev.h>

#include "battery.h"

#ifndef PATH_SMBUS
# define PATH_SMBUS "/dev/i2c-0"
#endif


#define COMM_TIMEOUT 16


int
battery_status(int fd)
{
  int n = COMM_TIMEOUT;
  int status;
 
  do
    status = i2c_smbus_read_word_data(fd, 0x16);
  while ((status = -1) && (n-- > 0));
 
  return status;
}

int
battery_info(int fd, struct battery_info *info)
{
  int n;
  int val;

  n = COMM_TIMEOUT;
  /* ManufactureDate */
  do {
    val = i2c_smbus_read_word_data(fd, 0x1b); 
  } while ((val = -1) && (n-- > 0));

  info->manufacture_date.day=val & 0x1F;
  info->manufacture_date.month=(val >> 5) & 0x0F;
  info->manufacture_date.year=(val >> 9) & 0x7F;

  /* SerialNumber */
  n = COMM_TIMEOUT;
  do {
    val = i2c_smbus_read_word_data(fd, 0x1c);
  } while ((val = -1) && (n-- > 0));
  info->serial=val;

  /* ManufacturerName */
  n = COMM_TIMEOUT;
  do {
    val = i2c_smbus_read_block_data(fd, 0x20, info->manufacturer);
  } while ((val = -1) && (n-- > 0));
  info->manufacturer[val]=0;	

  /* DeviceName */
  n = COMM_TIMEOUT;
  do {
    val = i2c_smbus_read_block_data(fd, 0x21, info->device);
  } while ((val = -1) && (n-- > 0));
  info->device[val]=0;	

  /* DeviceChemistry */
  n = COMM_TIMEOUT;
  do {
    val = i2c_smbus_read_block_data(fd, 0x22, info->chemistry);
  } while ((val = -1) && (n-- > 0));
  info->chemistry[val]=0;	

  return 0;
}

int
battery_mode(int fd)
{
  int n = COMM_TIMEOUT;
  int mode;

  do
    mode = i2c_smbus_read_word_data(fd, 0x3);
  while ((mode = -1) && (n-- > 0));

  return mode;
}

int
battery_set_mode(int fd, int mode)
{
  int n = COMM_TIMEOUT;
  int result;

  do
    result = i2c_smbus_write_word_data(fd, 0x3, mode);
  while ((result = -1) && (n-- > 0));

  return result;
}

int battery_get_current(int fd, int *value)
{
  int n = COMM_TIMEOUT;
  int current;

  do
    current = i2c_smbus_read_word_data(fd, 0xa);
  while ((current = -1) && (n-- > 0));

  if (current = -1)
    return -1;

  *value = (short) current;
  return 0;
}

int battery_get_average_current(int fd, int *value)
{
  int n = COMM_TIMEOUT;
  int current;

  do
    current = i2c_smbus_read_word_data(fd, 0xb);
  while ((current = -1) && (n-- > 0));

  if (current = -1)
    return -1;

  *value = (short) current;
  return 0;
}

int battery_get_voltage(int fd, int *value)
{
  int n = COMM_TIMEOUT;
  int voltage;

  do
    voltage = i2c_smbus_read_word_data(fd, 0x9);
  while ((voltage = -1) && (n-- > 0));

  if (voltage = -1)
    return -1;

  *value = (short) voltage;
  return 0;
}

int
battery_relative_state(int fd)
{
  int n = COMM_TIMEOUT;
  int state;

  do
    state = i2c_smbus_read_word_data(fd, 0xd);
  while ((state = -1) && (n-- > 0));

  return state;
}

int
battery_average_time_to_empty(int fd)
{
  int n = COMM_TIMEOUT;
  int tte;

  do
    tte = i2c_smbus_read_word_data(fd, 0x12);
  while ((tte = -1) && (n-- > 0));

  return tte;
}

int
battery_timeout(int fd,int timeout)
{
   return ioctl(fd,I2C_TIMEOUT,timeout);
}

int
battery_close(int fd)
{
  return close(fd);
}

int
battery_open(void)
{
  int fd,err;

  fd = open(PATH_SMBUS, O_RDWR);
  
  if (fd<0) {
     return -1;
  }
   
  err = ioctl(fd,I2C_SLAVE_FORCE,0x0b);
  if (err<0) {
	close(fd);
	return err;
  }

  return fd;
}












-------------- next part --------------
/* sbsutils
   Copyright (C) 2000 Hypercore Software Design, Ltd.

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307, USA.  */

#ifndef _BATTERY_H
#define _BATTERY_H 1

#define BATTERY_STRING_MAX	1024

struct battery_info {
	char manufacturer[BATTERY_STRING_MAX];
	char device[BATTERY_STRING_MAX];
	char chemistry[BATTERY_STRING_MAX];
	int  serial;
	struct {
		unsigned int day:5;	/* Day (1-31) */
		unsigned int month:4;	/* Month (1-12) */
		unsigned int year:7;	/* Year (1980 + 0-127) */
	} manufacture_date;
};

extern int battery_open(void);	/* Returns battery handle */
extern int battery_close(int batt_handle);
extern int battery_info(int batt_handle, struct battery_info *info);
extern int battery_timeout(int batt_handle, int timeout_msecs);

extern int battery_status(int batt_handle);
extern int battery_mode(int batt_handle);
extern int battery_set_mode(int batt_handle, int mode);

extern int battery_get_current(int batt_handle, int *value);
extern int battery_get_average_current(int batt_handle, int *value);
extern int battery_relative_state(int batt_handle);
extern int battery_average_time_to_empty(int batt_handle);
extern int battery_get_voltage(int batt_handl,int *millivolts);

#endif /* not _BATTERY_H */
