From: tomov@molbio.mgh.harvard.edu (Vesko T. Tomov)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: Help getting hardware monitoring on Intel 855PM 82801DBM
Message-Id: <1114433388.5978.4.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1114109876.6001.26.camel@localhost.localdomain>
In-Reply-To: <1114109876.6001.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2005-04-22 at 09:47 +0200, Jean Delvare wrote:

> Hi Vesko,
> 
> > Is it possible to get at least the hard drive temperature
> > reported under linux?
> 
> It is, but not with lm_sensors. Try smartmontools:
>   http://smartmontools.sourceforge.net/
> The command:
>   smartctl -A /dev/hda | grep -i temper
> should give you what you want.
> 

This works great!  

I installed the latest lm_sensors (2.9.1) but I had the same results.  I
have contacted both Clevo and Sager about information on the monitoring
chip and interface in this computer but they haven't bothered to
respond.  So much for the "lifetime technical support!"  Thanks for all
your help.  If I find out any more details about this particular
hardware I will let you know.

Vesko



> > PS  Is it correct that I am replying to the mailing list, rather than
> > to your personal email address? 
> 
> Oh yes it is :)
> 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050425/d2758ee1/attachment.html
