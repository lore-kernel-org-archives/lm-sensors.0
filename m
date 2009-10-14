From: hamelg <hamelg@laposte.net>
Date: Wed, 14 Oct 2009 18:35:35 +0000
Subject: Re: [lm-sensors] Andigilog driver by George Joseph
Message-Id: <loom.20091014T202421-284@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
In-Reply-To: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

 <george.joseph <at> peakin.com> writes:

> Here's the latest patch.  Applies fine for me 2.6.25 - 2.6.27.4.
> 

Works fine until 2.6.30, unfortunately compiles no more after :( 
In testing since more 1 year, why isn't it in mainstream ?
Here is the error :

make -C /lib/modules/2.6.31-ARCH/build
M=/home/xxxxxx/BUILD/asc7621.sensors modules make[1]: Entering
directory `/usr/src/linux-2.6.31-ARCH' CC [M]
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.o
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c: In function
‘store_temp62’: /home/xxxxxx/BUILD/asc7621.sensors/asc7621.c:392:
warning: ISO C90 forbids mixed declarations and code
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c: In function
‘asc7621_detect’: /home/xxxxxx/BUILD/asc7621.sensors/asc7621.c:1237:
error: implicit declaration of function ‘i2c_attach_client’
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c:1265: error: implicit
declaration of function ‘i2c_detach_client’
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c: In function
‘asc7621_attach_adapter’:
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c:1296: error: implicit
declaration of function ‘i2c_probe’
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c: At top level:
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c:1304: error: unknown
field ‘detach_client’ specified in initializer
/home/xxxxxx/BUILD/asc7621.sensors/asc7621.c:1304: warning:
initialization from incompatible pointer type make[2]: ***
[/home/xxxxxx/BUILD/asc7621.sensors/asc7621.o] Error 1 make[1]: ***
[_module_/home/xxxxxx/BUILD/asc7621.sensors] Error 2 make[1]: Leaving
directory `/usr/src/linux-2.6.31-ARCH'


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
