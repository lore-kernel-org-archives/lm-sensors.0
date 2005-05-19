From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <Pine.LNX.4.58.0406252130410.9950@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Jun 2004, Jean Delvare wrote:

> [please remember to CC the mailing list on reply]
> 
> >Would a 2.4 patch be acceptable that merely returns a read or write error
> >to the thing trying to read the sensor information.
> 
> The drivers architecture will hardly let you implement this. I dont think
> you even have the possibility to return a non-zero error code in procfs
> (callback functions return void IIRC). In 2.6 it's better since
> callback functions can return an error value. However, in both cases
> (2.4 and 2.6) the registers are read all at once in a different function
> (mainly to ensure that the chip will get some rest from times to times)
> so if an error occurs, it occurs in that common update function, *not*
> in the reader callback function, so you cannot just return -1 and
> consider that the read failed. The register which failed may not be the
> one you are reading at that moment. You would have to keep track of
> whether each register read succeeded or failed. Although not unfeasable,
> this would be a very important change and I don't think it's
> acceptable in 2.4/CVS. I'm not even sure I would like this in 2.6...
> 
How about this (and I am assuming I will eventually have to produce a 
patch with the lm87 driver and drill it down into lib sensors for any real 
by in).  The routine that reads all the sensor data detects that there is 
error when reading one of the registers.  In the event of such an error it 
sets a value to one in the chips structure (or a bit).  If the read was 
succesful it sets it to zero.  A new proc entry is created called perhaps
readerror (please give me a better name).  Whenever someone is scanning 
the the proc values they can check this proc entry to see if the last read 
of the registers had no errors.  If it did not then all is well, if it did
then the program can act appropriately (ultimately, I would hope sensors 
the program would return an error and print one).  Also, when an error on 
a read is detected the syslog is notified.

I haven't thought through writes yet, but how does that sound for making 
read errors visable to user space?  This would not have to be implemented 
for all sensors either but if the mechansim was agreed upon implentation 
could occur as individuals cared.

Cheers...james
