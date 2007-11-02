From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 02 Nov 2007 07:46:55 +0000
Subject: Re: [lm-sensors] Utility for creating computate sensors.conf lines
Message-Id: <472AD5EF.7000706@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <472841C2.5060701@hhs.nl>
In-Reply-To: <472841C2.5060701@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 31 Oct 2007 21:38:45 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> You could use dmidecode's command line parameters to ease your parsing
>>> work or at least speed it up. In particular, option -t, and maybe -u.
>> I tried using -t, but although it works for types that dmidecode knows about 
>> like 20, it does not work for type 185, when I specify -t 185 I get no output.
> 
> Really? That would be a bug. Which version of dmidecode are you using?
> An equivalent test case works fine here with both 2.8 and CVS.
> 

Never mind, for some reason Fedora has been stuck at 2.7 for a long time, a 2.9 
build is queued for inclusion in the development branch when its unfrozen at 
the start of the F-9 cycle.

With 2.9 "dmidecode -t 185" works fine.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
