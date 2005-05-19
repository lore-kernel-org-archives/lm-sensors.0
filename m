From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors on ThinkPads
Message-Id: <3E2C87AA.4080602@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020927134750.B20006@Stimpy.netroedge.com>
In-Reply-To: <20020927134750.B20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So, there are lots of manufacturers of RFID chips, but none which have 
the functionality like the Atmel chip in question which we must blacklist.

I.e., I'm wondering if we can blacklist specific machines (e.g. older 
Thinkpads), or need to blacklist anything (including possible future 
machines) with this sort of RFID capability. (Sounds like the later, 
which is unfortunate.)

Just trying to wrap my head around this.  Thanks!


Phil


Mark Studebaker wrote:

>The AT24RF08 _is_ the RFID chip.
>It's really one of a kind.
>See datasheet link in README.thinkpad.
>
>  
>
