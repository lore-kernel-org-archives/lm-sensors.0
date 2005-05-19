From: sysadm@o2.pl (Marcin Szarek)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: hello, i've got a problem with
Message-Id: <1101907862.1886.19.camel@mi-msz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

First of all I'd like to congratulate you your lm_sensors project, and
thank for your job.

I've just get a new machine (tuned PC) designed for building network
monitoring and managing station. Motherboard is Gigabyte GA8 I875 with
chip IT8712F. OS is Fedora Core 3 with Linux kernel 2.6.9. I've
succesfully installed lm_sensors.
But, unfortunately though I try to tune my sensors.conf for couple of
days, I'm still in place where I haven't a clue what is temp1, temp2 and
temp3. As far as I have tested "temp3" seems like CPU temperature (the
value rises when I unplug the CPU fan), but this parameter value still
doesn't agree with that which one can see in BIOS health monitor (BIOS
shows ~51C and lm_sensors ~43C). Maybe I need some compute formula? How
to discover/calculate such formula?
However temp1 and temp2 still are totally mysterious to me. How can I
discover what are these all tempX parameters? How to set up proper
compute formulas?

Please help me guys!

TIA,
best regards
--

  .~.       MARCIN SZAREK <sysadm@pomin.ten.fragment.o2.pl>
  /V\         Bumar-Fablok S.A. IT systems administrator
 // \\	     Linux Counter Project registered user #263125
/(   )\  ** There are only 10 types of people in this world; **
 ^`~'^   ** those who understand binary and those who don't. **
