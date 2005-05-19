From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: LM83 test results
Message-Id: <20030806184342.42095474.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806122107.6d678b30.khali@linux-fr.org>
In-Reply-To: <20030806122107.6d678b30.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 2.8.0 from the web page.

Could you download sensors-detect CVS and give it a try? (unload the
lm83 driver first)
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 10: XX XX XX XX XX XX XX XX XX 19 XX XX XX XX XX XX 
> 20: 20 21 22 23 XX XX XX XX XX XX XX XX XX XX XX XX 
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 50: 50 51 52 53 54 55 56 57 XX XX XX XX XX XX XX XX 
> 60: XX XX XX XX 64 XX XX XX XX XX XX XX XX XX XX XX 
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 

There are many devices. 0x50 to 0x57 are eeproms (real or fake, that I
can't tell). There is a LM device at 0x19. The devices from 0x20 to 0x23
are really mysterious. If you are curious, you could run "i2cdump 0
0x20" and see if it returns anything interesting. Warning! We don't have
the slightest idea on what this device can be, so running this command
is potentially dangerous. Do as you want, as I explained in the previous
e-mail.

> I have been told that "Sensor D1 reads the CPU die temperature, the 
> local sensor reads the LM83's own temperature. Sensors D2 and D3 
> measure nothing." 

Who told you that? FYI, the matchings are:

temp1   local
temp2   D1
temp3   D2
temp4   D3

Temp1 has to be the LMXX own temperature, temp2-4 can be anything remote
or nothing at all.

> In my testing I have seen that temp1 is fairly stable 36-37. The
> other ones vary between 33-45 mostly.

Am I right guessing you have always seen temp2=temp3=temp4?

> # i2cdump 0 0x19

I suspect it is a LM82, not a LM83. The LM82 is basically a cut down
LM83 with a singe remote temperature instead of 3. Do you have any
reason to believe you must have a real LM83, apart from the fact that
sensors-detect told you so?

> > Are these four entries correct? Do you have 4 SDRAM memory modules
> > of 256MB each?
> Well most likely. I have 1GB of memory. If there are any empty slots I
> do not know. 

Don't you have the possibility to open the box and check? (You could
check what your sensor chip really is BTW.)

> Any other things to test?

Yes, I'd like to verify my theory that your chip is a LM82.

Could you try setting limits? Do:

echo 80 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp1
echo 90 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp2
echo 100 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp3
echo 110 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp4

Wait a few seconds, and run "i2cdump 0 0x19 b" again. I should be able
to conclude.

> Are the output from the commands I tried correct? seems strange!

Unless hexadecimal is your natural alphabet and you speak the sensor
chip language every day, yes, seems strange. Normally, users don't have
to deal with this ;)

Thanks a lot for reporting!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
