From: belle@bazuin.nl (L.P.H. van Belle)
Date: Tue, 29 Nov 2005 11:36:09 +0000
Subject: FW: [lm-sensors] Asus P4S533-E need help with CPU Fan.
Message-Id: <200511291035.jATAZxZ12150@engine.bazuin.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200511290918.jAT9IPZ10439@engine.bazuin.nl>
In-Reply-To: <200511290918.jAT9IPZ10439@engine.bazuin.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Great i didnt find that on the site, and i searched long.. 
very good, thank you.

this :
Did you set the fan1_div properly? Try echo 8 >
/sys/bus/i2c/devices/0-002d/fan1_div

was the solution

greatings 

Louis


-----Oorspronkelijk bericht-----
Van: Ymu@Winbond.com.tw [mailto:Ymu@Winbond.com.tw] 
Verzonden: dinsdag 29 november 2005 10:50
Aan: belle@bazuin.nl; lm-sensors@lm-sensors.org
Onderwerp: RE: [lm-sensors] Asus P4S533-E need help with CPU Fan.

Hello,

> 
> Im running Debian Sarge with kernel 2.6.12 from testing.
> This is on a asus P4S533-E mainboard.
> 
> Everything execpt 1 is running fine, so is there somebody who
> know's how to get the CPU Fan speed out of this.
> I checked the bios hardware monitor and
> there is a Fan Speed (running at 2549 RPM)
> 
> and yes there is "ignore fan1" => 3, but when i enable it ( all three
)
> the output is 0
>

Since I know almost nothing about this chip, I would give you two links

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#
Section-4_002e1
Did you set the fan1_div properly? Try echo 8 >
/sys/bus/i2c/devices/0-002d/fan1_div

Another link:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#
Section-4_002e16


Best Regards
Yuan Mu



======================================
========The privileged confidential information contained in this
email is intended for use only by the addressees as indicated by the
original sender of this email. If you are not the addressee indicated in
this email or are not responsible for delivery of the email to such  a
person, please kindly reply to the sender indicating this fact and delete
all copies of it from your computer and network server immediately. Your
cooperation is highly appreciated. It is advised that any unauthorized use
of confidential information of Winbond is strictly prohibited; and any
information in this email irrelevant to the official business of Winbond
shall be deemed as neither given nor endorsed by Winbond.

======================================
========If your computer is unable to decode Chinese font, please
ignore the following message.It essentially repeats the statement in English
given above.%;+H%s$:)R't5X(99q$l*:0]2#)J>w1K)J8j0T,
6H1BEv-l5o+H$H+|)w$'&,+H$H(z>\\$'%N.
02(O1z(C+D3Q+|)w$'&,+H$H)N&]%t&s-l&]&b%<8g1BEv*:1!'N$'$U&,(l%;+H%s,
=P1z'i*>-l5o+H$H(C%_'Y1N+H%s1q9q8#;P:t8t&x*A>9$$$)%H.x0#. 9o)s1z*:&X'@,
'Z-L%}&9-PAB. /S&94#?t,
%t&s%<8g1BEv>U&[(O%N5X(99q$l*:>w1K8j0T*:&f,0,O3QDY.f8T$n*:.
+H%s;P5X(99q$l@g7~5LCv$'$:.e,$#1o5x,05X(99q$l$'%_3u)N7N(#.
--
*** Bazuin & Partners Managed E-mail Filter scanned this email for viruses ***
