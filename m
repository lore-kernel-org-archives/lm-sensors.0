From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: hello, i've got a problem with
Message-Id: <Pine.LNX.4.58.0412022049480.2569@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101907862.1886.19.camel@mi-msz>
In-Reply-To: <1101907862.1886.19.camel@mi-msz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for late answer.

> First of all I'd like to congratulate you your lm_sensors project, and
> thank for your job.

Thanks :)

>
> I've just get a new machine (tuned PC) designed for building network
> monitoring and managing station. Motherboard is Gigabyte GA8 I875 with
> chip IT8712F. OS is Fedora Core 3 with Linux kernel 2.6.9. I've
> succesfully installed lm_sensors.

Acording to MBM database
GA8 I875 Ultra  ITE8712F ITE8712F 1 ITE8712F 3 diode

temp3 should be CPU temp (you need to set sensor type to diode)
temp1 is case/environment (thermistor)
temp2 is perhaps unconnected

In correct it87-* section of cfg add/edit:

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435

Dont forget to run sensors -s to "apply changes"
check with "sensors" command to see how it goes.

Try to play some game that eats lot of CPU (or theora encoding :)

> But, unfortunately though I try to tune my sensors.conf for couple of
> days, I'm still in place where I haven't a clue what is temp1, temp2 and
> temp3. As far as I have tested "temp3" seems like CPU temperature (the
> value rises when I unplug the CPU fan), but this parameter value still
> doesn't agree with that which one can see in BIOS health monitor (BIOS
> shows ~51C and lm_sensors ~43C). Maybe I need some compute formula? How
> to discover/calculate such formula?

Snip from FAQ:
Bios might be doing some correction itself.

However, the offset you are introducing might not be necessary. If you
tried to have Linux idle temperature and BIOS "idle" temperature match,
you may be misguided. We have a Supermicro (370DLE) motherboard and we
know that its BIOS has a closed, almost undelayed while(1) loop that keeps
the CPU busy all the time. Linux reads 26 degrees idle, BIOS reads 38
degrees. Linux at full load is in the 35-40 degrees range so this makes
sense.

> Please help me guys!

Sure :)

There are two ways:
1) get the information from manufacturer (good luck)
2) bios diassembly (I can do it if you really really need it but I have
very limited free time this days. It takes 4 hours approx)

here is how to do it yourself:
http://www.assembler.cz/biohack.html

Regards

Rudolf
