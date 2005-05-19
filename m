From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: ADM1031 Driver (was long time ago <driver for mic184 chip>)
Message-Id: <421E62A0.1000900@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20172.192.88.166.35.1109235034.squirrel@avrel.homeip.net>
In-Reply-To: <20172.192.88.166.35.1109235034.squirrel@avrel.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alexandre,

I was able to sneak some time in today between builds and look at this 
driver some more. I was able to get your driver to work with a simple 
modification. Let me describe my setup first. Kernel is 2.6.9 except 
when I started having problems with this driver I brought adm1031.c from 
2.6.10 and put the normal_i2c stuff back in. It appears that in 
adm1031_attach_adapter() adapter->class is zero and HWMON is 1 so I get 
the return 0 instead of calling i2c_detect. I am using an adm1030 part. 
When I remove the adapter->class test then the driver is up and running 
fine. I see some other drivers have removed this sort of test but I have 
not looked into the consequences of doing this. Any ideas or clues on 
what I might need to fix to get the class set properly?

Thanks
Frank





Alexandre d'Alton wrote:

>Hi Frank,
>
>I just niticed that you have problems with the lm1030 driver in the
>following message :
>
>http://article.gmane.org/gmane.linux.drivers.sensors/563
>
>As I am one of the authors, I'd like to resolve the problems, can you
>explain precisely what are the problems that you have ?
>
>Thanks,
>
>Alexandre.
>
>  
>
