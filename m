From: "John Brier" <johnbrier@gmail.com>
Date: Thu, 25 Dec 2008 20:58:46 +0000
Subject: Re: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't
Message-Id: <f421b28c0812251258h3c0be4d6p29fd9444d23e6673@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
In-Reply-To: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 25, 2008 at 3:50 PM, John Brier <johnbrier@gmail.com> wrote:
> I guess this means I have the wrong version of libc6 installed now.
> I'm off to figure out if I broke my system.. lol

As it turns out dpkg -i installed the packages libsensors4 and
lm-sensors 3 but did not fully install them. libc6 was unchanged. Now
dselect wants to remove them because of the unmet libc6 requirement
when I upgrade. So I'm having Debian issues now. Thanks very much Jean
for helping me!

John

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
