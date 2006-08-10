From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Thu, 10 Aug 2006 13:15:48 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04708A171DF@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No additional patches applied....

~@> systool -c hwmon -v
Error opening class hwmon
~@> 


-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Thursday, August 10, 2006 4:43 AM
To: Calabro, Anthony
Cc: LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

> If I run sensors  v2.10.0 with the libsensors v2.8.7, the parser works

> correctly with the original sensors.conf input file.  I wonder if 
> there is a problem with where it is being compiled...

All the parsing code is in the library, "sensors" itself only queries
for data and print it. So the version of "sensors" shouldn't matter at
all.

Indeed there seems to be a problem at compilation time, but I don't have
any idea on what could cause that much trouble, given that you use the
same version of flex everyone does. Unless your distribution has some
additional patch applied?

> So right now I have sensors 2.10.0 running with either libsensors 
> 2.8.7 or 2.10.0.  in either case I am getting weird sensors 
> readings....  Most voltages read 4.08 V, and the fans and temps are 
> not returning any values.

Could be that your chip isn't properly wired, but I wouldn't trust
libsensors much given the trouble you have with the configuration file
parsing. Also, I suppose that the values reported were correct before
the kernel update? Please provide the output of:
  systool -c hwmon -v

--
Jean Delvare



