From: pbhuntley@netscape.net (Pam Huntley)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors on ThinkPads
Message-Id: <350A69FC.0A35656D.033017BB@netscape.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020927134750.B20006@Stimpy.netroedge.com>
In-Reply-To: <20020927134750.B20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm sorry it's taken me so long to get back to you on this, I had another project which was requiring 150% of my time.  Now that I actually get to sleep again,  I have some time to go back to this and look at it some more.

Output of ibm.pl:
[root@tester lm_sensors-2.6.5]# ./ibm.pl
RSD PTR found at 0xF7030.
OEM string "IBM   ".
This is an IBM system.

Attached is dmesg output.

I did apply the dmidecode patch, here is the output of dmidecode:
[root@tester lm_sensors-2.6.5]# ./prog/detect/dmidecode
SMBIOS 2.31 present.
DMI 2.31 present.
48 structures occupying 1636 bytes.
DMI table at 0x0FF7C000.
dmi: read: Success
RSD PTR found at 0xF7030.
Reserved check failed.
OEM IBM
PNP BIOS present.

sensors-detect still presents the same output as before.

I think that's everything.  Please let me know how it goes.

Pam


Khali <khali@linux-fr.org> wrote:

>(BTW: I don't seem to have received the last two messages I sent to the list; 
>is there something wrong?)
>
>> dmi: read: Success
>This sucks. Dmidecode failed and I found out why (pretty lame bug indeed). 
>Patch attached.
>
>Pam, do you have the time and knowledge to patch the dmidecode source that 
>comes with lm_sensors-2.6.5 (in prog/detect IIRC), reinstall it and rerun 
>sensors-detect? Could you also send us the output of dmesg and the output of 
>dmidecode itself, would be perfect :)
>
>I also attached a simple perl script. Please run it as root (I swear it is 
>safe) and send me the output. It is an alternative method for IBM detection I 
>am working on. If it works, we can get rid of dmidecode really soon.
>
>> Obviously I hit ctrl-c at that point.
>There were no risk of breaking anything... Well, in theory ;)
>
>Thanks A LOT for testing, be sure we appreciate :)
>Khali.
>

__________________________________________________________________
The NEW Netscape 7.0 browser is now available. Upgrade now! http://channels.netscape.com/ns/browsers/download.jsp 

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.out
Type: application/octet-stream
Size: 8700 bytes
Desc: dmesg.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021016/99450302/dmesg.obj
