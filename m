From: joker@netswarm.net (Christian Birchinger)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Detected i2c-viapro + lm75 chips display *only* CPU temerature
Message-Id: <yam8912.1032.213206304@mail.joker>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020525032423.A5531@netswarm.net>
In-Reply-To: <20020525032423.A5531@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried "w83781d force_as99127f" before but didn't know
the correct address. I found following working command
in a forum:

modprobe w83781d force_as99127f=0,0x2d

So if anyone has a A7V333 the line above works
(A mainboard database would be a nice thing ;)

On 27-May-02, Mark Studebaker wrote:
> Whatever you have, we don't support. Sorry. The W83518D does
> not appear to be a hardware monitor. If you figure out what
> chip you have, you can watch our New Drivers page for status or
> if it's not on there let us know.
> 
> http://www.winbond-usa.com/news/pressrel/09-17-2001.shtml
> 
> Christian Birchinger wrote:
>> Hello,
>> I have the following problem with my lm_sensors2 setup.
>> 
>> Summary: Detected i2c-viapro + lm75 chips display *only* CPU
>> temerature
>> 
>> Details and Systeminfo:
>> I'm using I2C and lm_sensors2 CVS version from 25 May 2002
>> 
>> I have an Asus A7V333/A/R/F Mainboard which shows voltages
>> fanspeed and CPU temp in the BIOS monitor.
>> 
>> The sensors-detect script tells me to load:
>> i2c-viapro, pcf8591 and lm75
<stuff removed>
