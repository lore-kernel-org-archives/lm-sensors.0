From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors on ThinkPads
Message-Id: <3DA75FEF.FEB4F08B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020927134750.B20006@Stimpy.netroedge.com>
In-Reply-To: <20020927134750.B20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Pam,
I checked in Khali's patch below if you would rather get it from CVS.
mds

Khali wrote:
> 
> (BTW: I don't seem to have received the last two messages I sent to the list;
> is there something wrong?)
> 
> > dmi: read: Success
> This sucks. Dmidecode failed and I found out why (pretty lame bug indeed).
> Patch attached.
> 
> Pam, do you have the time and knowledge to patch the dmidecode source that
> comes with lm_sensors-2.6.5 (in prog/detect IIRC), reinstall it and rerun
> sensors-detect? Could you also send us the output of dmesg and the output of
> dmidecode itself, would be perfect :)
> 
> I also attached a simple perl script. Please run it as root (I swear it is
> safe) and send me the output. It is an alternative method for IBM detection I
> am working on. If it works, we can get rid of dmidecode really soon.
> 
> > Obviously I hit ctrl-c at that point.
> There were no risk of breaking anything... Well, in theory ;)
> 
> Thanks A LOT for testing, be sure we appreciate :)
> Khali.
> 
> 
>                                  Name: dmidecode-1.4-fixread.diff
>    dmidecode-1.4-fixread.diff    Type: Plain Text (text/plain)
>                              Encoding: 8bit
> 
>              Name: ibm.pl
>    ibm.pl    Type: Perl Program (application/x-perl)
>          Encoding: base64
