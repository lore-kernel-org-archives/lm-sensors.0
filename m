From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/dump i2cbusses.c
Message-Id: <3FC6898D.DF9ECF07@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The 2.6 i2c-dev bus numbers don't necessarily match i2c-adapter bus
numbers.
If you rmmod and re-insmod a bus driver, the driver seems to get its old
i2c-dev bus number back. But the i2c-adapter number increments.
Don't know why. It would be much better if they matched.

Most userspace tools need the i2c-dev numbers since they are going
to use /dev/i2c-x devices to access the bus.

The bus numbers reported by libsensors apps are the i2c-adapter numbers.
I think it has to be that way since we don't need i2c-dev and therefore
can't count on it being installed.

So you can't take a bus number from 'sensors' and then take that
number and use it in 'i2cdump', for example.


author@mordac.netroedge.com wrote:
> 
> Update of /home/cvs/lm_sensors2/prog/dump
> In directory mordac.netroedge.com:/tmp/cvs-serv14049
> 
> Modified Files:
>         i2cbusses.c
> Log Message:
> (mds) report i2c-dev bus numbers rather than i2c-adapter numbers,
>       which may be different.
