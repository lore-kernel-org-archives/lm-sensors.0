From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 28 May 2005 00:36:18 +0000
Subject: [lm-sensors] Query: libsensors, adm9240 driver and user feedback
Message-Id: <oi7f9110p5t7k1p3f8sqjvb9h8k39mkg4g@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gang,

I put up a patch for adm9240 port for 2.6.11.10 on my website:
  http://scatter.mine.nu/hwmon/adm9240/
and scored me a live tester :)

quote:
>When I run 'sensors' I get 
>
>ds1780-i2c-0-2d
>Adapter: SMBus I801 adapter at ccd0
>ERROR: Can't get IN0 data!
>ERROR: Can't get IN1 data!
>ERROR: Can't get IN2 data!
>ERROR: Can't get IN3 data!
>ERROR: Can't get IN4 data!
>ERROR: Can't get IN5 data!
>F1:          0 RPM  (min =    0 RPM, div = 8)          
>F2:          0 RPM  (min =    0 RPM, div = 8)          
>T1:        +37.0?C  (high =  +127?C, hyst =   +13?C)   
>vid:       +1.95 V
>alarms:   Chassis intrusion detection                  ALARM

Seems to me I need add alternate in0..in5 naming to libsensors?

At the moment libsensors uses the chip defined pin labels and is 
documented as "this may change", am I on right track?

Might there be something else I should look for?  Also, the user 
wants to use sensord, anything else I should check?

Thanks,
--Grant.

