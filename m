From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 03 Dec 2010 08:37:33 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <AANLkTinvSx_FaNWSZQU9ikN+fWsGhRCJrrFSuNWwTckE@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 2, 2010 at 10:50 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Someone else suggested to add "acpi=force irqpoll" to the linux command
> line.

Interesting :) My suspicion is that the syncronization with the EC is
going bad (somehow).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
