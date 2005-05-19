From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: P4B SMBus hotplugging:
Message-Id: <3C7C499E.93E59715@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.3.93.1020215131031.14900A-101000@alwa02.physik.uni-siegen.de>
In-Reply-To: <Pine.OSF.3.93.1020215131031.14900A-101000@alwa02.physik.uni-siegen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thank you very much for the contribution.
It's checked in to CVS.
mds

Ilja Rauhut wrote:
> 
> Dear Sir or Madam,
> 
> according to ticket number 755 I am not the only one who has problems
> with the broken BIOS of the Asus P4B.
> I have rewritten the m7101 driver in lmsensors. It know activates the
> SMBus interfaces in boards with Intel i801BA.
> The files are in the attachment. Could you have a quick view in the code
> and comment things, if they are not programmed properly?
> I am not very good in programming, but the module is running fine for me.
> After correcting the code it would be nice to include it in the hotplug
> examples of lmsensors.
> It seems that Asus is disabeling the SMBus device on some boards for
> purpose - look into Readme.txt for details.
> 
> Yours Sincerely
> Ilja Rauhut
> 
> 
>                            Name: p4b_smbus.tar.bz2
>    p4b_smbus.tar.bz2       Type: unspecified type (APPLICATION/octet-stream)
>                        Encoding: BASE64
>                     Description: P4B Hotplug module
