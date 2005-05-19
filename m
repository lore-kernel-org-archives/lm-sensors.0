From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40158FD6.50503@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Please have a look at set_pwm(). What shall I do with an unsupported
>>value? Is it ok to return -1?
> 
> Which values do you consider unsupported? (Pardon my ignorance, I've
> never dealt with chipsets with PWM so far).

I was wrong. Correct is set_fan_div().

static ssize_t set_fan_div (struct i2c_client *client, struct fscher_data 
*data, const char *buf, size_t count, int nr, int reg)
{
   /* supported values: 2, 4, 8 */
   int v = simple_strtoul(buf, NULL, 10);

   switch (v)
   {
   case 2:    v = 1;    break;
   case 4:    v = 2;    break;
   case 8:    v = 3;    break;
   default:   return -1;
   }

   /* bits 2..7 reserved => mask with 0x03 */
   data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &= ~0x03;
   data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |= v;

   fscher_write_value(client, reg, data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]);
   return count;
}

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
