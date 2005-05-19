From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40158590.9080806@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Is there a guide, how to port the sensors program?
>>
>>Without changes, sensors just gives me the following:
>>
>>fscher-i2c-0-73
>>Adapter: SMBus I801 adapter at 2000
>>+12V:           +11.86 V
>>+5V:             +5.05 V
>>Battery:         +3.05 V

The above is for kernel 2.6.1 and below for kernel 2.4.22:

fscher-i2c-0-73
Adapter: SMBus I801 adapter at 2000
Temp1/CPU:      +50.00 C
Temp2/MB:       +41.00 C
Temp3/AUX:      +32.00 C
Fan1/CPU:          960 RPM
Fan2/AUX:          960 RPM
Fan3/PS:          1680 RPM
+12V:           +118.58 V
+5V:            +50.47 V
Battery:        +30.54 V

The problem is, that the voltage values still need to get devided by 10.

Shall I scale the values by 1000 for kernel 2.6.1 and by 100 for kernel 2.4.22
and remove the factor 1000 from sensors.conf?

BTW: changing *nrels_mag below from 2 to 3 fixed it for procfs, but still not 
for sensors.

void fscher_volt(struct i2c_client *client, int operation, int ctl_name,
                  int *nrels_mag, long *results)
{
   struct fscher_data *data = client->data;
   if (operation = SENSORS_PROC_REAL_INFO)
     *nrels_mag = 3;
   else if (operation = SENSORS_PROC_REAL_READ) {

Anyway, I'll work on it tomorrow :-))

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

