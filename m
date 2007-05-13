From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 May 2007 11:51:14 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp add more safety checks
Message-Id: <20070513135114.37870687@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4634A411.4030703@assembler.cz>
In-Reply-To: <4634A411.4030703@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Fri, 11 May 2007 00:39:10 +0200, Rudolf Marek wrote:
> Hello
> 
> here comes updated patch, I  added a check if certain Core2 are desktop or 
> mobile processors (using yet another not officially documented register - but it 
> should be ok ). They have same CPUID as desktop but are in fact mobile ;)
> 
> Everyone, please try the patch with core2 and core notebooks/desktops, I do not 
> have any chance to test it.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> This patch adds detection of AE18 Errata of Core processor and warns
> users that the absolute readings might be wrong for Core2 users.

Tested, it works fine for me (Core 6/14/8). The driver is no longer
printing any warning when loaded, and otherwise behaves the same as
before.

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
