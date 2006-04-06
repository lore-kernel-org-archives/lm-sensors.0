From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Apr 2006 19:44:49 +0000
Subject: [lm-sensors] Reading ASUS P5GD1-VM sensors
Message-Id: <20060406214449.4556ca21.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44354E63.5090703@gmail.com>
In-Reply-To: <44354E63.5090703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Reading the P5GD1-VM sensors
> 
> I have been using lmsensors for quite a while now but recently stumbled 
> across an ASUS P5GD1-VM MotherBoard at work.
> 
> I installed the i2c and lmsensors, read the quick installation 
> documentation, ran the suggested utilities and was able to identify the 
> sensor chip as a Winbound w83627ehf.
> 
> I then applied all the recommendations, updated the files as specified, 
> restarted my machine and came out empty handed. No sensors detected. 
> Spent quite a bit of time googling to get further information about the 
> w83627ehf Super IO Chip, but results were unsuccessful.
> (...)
> Of course Asus Probe reads all parameters correctly, so why was it that 
> I could not do it in Slackware 10.2 using a 2.4.31 kernel.

Because the w83627ehf driver only exists for Linux 2.6 at the moment.
Nobody ported it back to lm_sensors CVS (which is where drivers for
Linux 2.4 are maintained), most probably due to a lack of resources and
interest.

I just modified our "new drivers" web page to mention your interest in
a backport.

Your trick of forcing the w83781d driver is interesting, although a bit
complex for the regular users, and there are also some new features of
the W83627EHF chip which you will miss. But I agree that it's better
than nothing.

-- 
Jean Delvare

