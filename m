From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 28 Sep 2005 06:22:10 +0000
Subject: [lm-sensors] Re: [PATCH] Request only really used I/O ports in
Message-Id: <5d6kj1pgrf7cg6gqgm24te4e4u6ojg223a@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907181415.GA468@vana.vc.cvut.cz> <20050907210753.3dbad61b.khali@linux-fr.org> <431F4006.6060901@vc.cvut.cz> <20050925195735.1ef98b40.khali@linux-fr.org> <43371F89.7090704@vc.cvut.cz> <20050928024956.GA24527@vana.vc.cvut.cz>
In-Reply-To: <20050928024956.GA24527@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jean Delvare <khali@linux-fr.org>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, 28 Sep 2005 04:49:56 +0200, Petr Vandrovec <vandrove@vc.cvut.cz> wrote:

>On Mon, Sep 26, 2005 at 12:07:05AM +0200, Petr Vandrovec wrote:
>> Jean Delvare wrote:
>> 
>> >I would also want you to check that all of the W83627HF, W83627THF,
>> >W83697HF and W83637HF chips do not decode ports other than +5 and +6. I
>> >hope and guess so, but if not we will need slightly more complex code.
>> 
>> I've tested multiple revisions of W83627HF and W83627THF in various Tyan 
>> and ASUS boards.  I'll perform some search accross my other computers, but 
>> I'm not aware about any using W83697HF or W83637HF.
                                 ^^^^^^^^
root@sempro:~# sensors
w83697hf-isa-0290
Adapter: ISA adapter
  VCore:   +1.55 V  (min =  +1.52 V, max =  +1.68 V)
   3.3V:   +3.28 V  (min =  +3.14 V, max =  +3.47 V)
     5V:   +5.08 V  (min =  +4.76 V, max =  +5.24 V)
    12V:  +11.98 V  (min = +11.37 V, max = +12.59 V)
   -12V:  -11.86 V  (min = -12.60 V, max = -11.36 V)
    -5V:   -5.10 V  (min =  -5.25 V, max =  -4.75 V)
   V5SB:   +4.95 V  (min =  +4.75 V, max =  +5.26 V)
  VBatt:   +3.38 V  (min =  +2.90 V, max =  +3.41 V)
CPU Fan:  3183 RPM  (min = 1500 RPM, div = 4)
CaseFan:  1371 RPM  (min = 1196 RPM, div = 8)
Ambient:     +32?C  (high =   +50?C, hyst =   +45?C)   sensor = thermistor
    CPU:   +56.5?C  (high =   +66?C, hyst =   +61?C)   sensor = diode           (beep)
alarms:
beep_enable:
          Sound alarm enabled

root@sempro:~# lsmod
Module                  Size  Used by
w83627hf               24656  0
hwmon_vid               2048  1 w83627hf
i2c_isa                 3392  1 w83627hf
e100                   33860  0
root@sempro:~# uname -r
2.6.14-rc2-git6b

Your patch didn't break things here :o)

Grant.


