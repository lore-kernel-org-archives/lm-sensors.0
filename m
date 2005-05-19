From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <20040627181010.4df42fbf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> How about this (and I am assuming I will eventually have to produce a 
> patch with the lm87 driver and drill it down into lib sensors for any
> real by in).  The routine that reads all the sensor data detects that
> there is error when reading one of the registers.  In the event of
> such an error it sets a value to one in the chips structure (or a
> bit).  If the read was succesful it sets it to zero.  A new proc entry
> is created called perhaps readerror (please give me a better name). 
> Whenever someone is scanning the the proc values they can check this
> proc entry to see if the last read of the registers had no errors.  If
> it did not then all is well, if it did then the program can act
> appropriately (ultimately, I would hope sensors the program would
> return an error and print one).  Also, when an error on a read is
> detected the syslog is notified.
> 
> I haven't thought through writes yet, but how does that sound for
> making read errors visable to user space?  This would not have to be
> implemented for all sensors either but if the mechansim was agreed
> upon implentation could occur as individuals cared.

Mmm, I don't see much benefit over what is done in w83l785ts.

With your method, the user application will be told that some of the
values are wrong, but not which ones. So every value will have to be
ignored. Second, every application will have to do it. I guess that the
application will return the old value instead in this case, which means
it'll have to remember it. All in all you want to do at the chip level
in user-space what my method (as implemented in the w83l785ts driver)
does at feature level in kernel-space, so it's finer grained and not
every application has to handle it. Since our chip drivers already cache
the old values, the amount of additional code needed is low.

Please take a look at what is done in w83l785ts and tell me why it
woudln't solve you problem, if it actually doesn't.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
