From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: vt8231 support in 686a
Message-Id: <4154ADB4.7060400@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409221055250.6322@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409221055250.6322@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

correct. see CVS comments for revision 1.25.

Jean Delvare wrote:
> On Wed, 22 Sep 2004 11:11:12 +0200 (CEST), Rudolf Marek wrote
> 
>>on the http://secure.netroedge.com/~lm78/supported.html
>>is written that vt8231 is supported by via686a which is wrong
>>I think because:
>>http://archives.andrew.net.au/lm-sensors/msg18590.html
>>
>>A user with epia v10000 board tried
>>modprobe i2c-isa
>>modprobe via686a
>>and it was not working ( no driver has been registered)
>>nothing in logs, sysfs mounted.
>>
>>Please fix the table or tell me what I missed thanks :)
> 
> 
> I think you're right and the table is wrong. The VT8231 has its own driver
> named (aha!) vt8231. I guess that the via686a driver was originally supporting
> both  and then a fork occured and we forgot to update the page. Mark
> (Studebaker), do you confirm?
> 
> The web page sure needs fixing.
> 
