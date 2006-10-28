From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 28 Oct 2006 21:40:55 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <4dfa50520610281440j3b3a18c0j410baf6d88c487ba@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On 10/28/06, Christian Mahr <christian.mahr.ulm at arcor.de> wrote:
> Hi David
>
> I have the same board ASUS P5B Deluxe wifi for 1 week now. The one with the
> W83627DHG chip
>
> I?d like to give the modified driver for w83627 a try - if you don?t mind.
> Currently I am running a 2.6.18.1 kernel (already withe coretemp patches) but
> I can also switch to a more recent one if required.

There is this file which Michael Nelson used on his 2.6.18 kernel successfully:
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj

It is not a part of the kernel yet. In the thread where Michael tested
it, we discussed the changes that need to be made. When a version is
ready for the kernel, would you be willing to test it also?

David

