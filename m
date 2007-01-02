From: trinityrosh@gmail.com (Rosh shah)
Date: Tue, 02 Jan 2007 13:10:26 +0000
Subject: [lm-sensors] Problem making lmsensors work!
Message-Id: <1bebf72e0701020510r507504d7la691bf637eaabb67@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1bebf72e0612131206r24bdb4c0vd0f35f9da801d8b8@mail.gmail.com>
In-Reply-To: <1bebf72e0612131206r24bdb4c0vd0f35f9da801d8b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you very much for your reply and time. I appreciate that. I upgraded
my lmsensors and also added vt1211 as an external module in kernel
2.6.16kernel. Now it works.

Thanks again for your time and help:-)

Rosh

On 12/21/06, Jean Delvare <khali at linux-fr.org> wrote:
>
> Hi Rosh,
>
> On Wed, 13 Dec 2006 15:06:59 -0500, Rosh shah wrote:
> > Hello ,
> > I am having trouble in making lmsensors work on my machine. Following
> are
> > the details:
> >
> > Motherboard: Via EPIA SP - Series Mini ITX Mainboard
> > Kernel Version: 2.6.16
> > Chipset: VIA VT8237R
> > Sensors version: 2.10
> >
> > When i run sensors, the following errors comes up:
> > Sensors not found!
> >
> > Sensors detect gives the following result:
> >
> > #sensors-detect revision 1.413 (2006/01/19 20:28:00)
> > (...)
> > # Warning: the required module vt1211 is not currently installed on your
> system.
> > # For status of 2.6 kernel ports see
> http://secure.netroedge.com/~lm78/supported.html
> > # If driver is built-in to the kernel, or unavailable, comment out the
> following line.
> > modprobe vt1211
>
> The vt1211 driver was only merged recently in the Linux 2.6 tree,
> you'll need kernel 2.6.19 or later to get it to work. You'll also need
> lm_sensors 2.10.1 or later.
>
> --
> Jean Delvare
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070102/89f1780b/attachment.html 
