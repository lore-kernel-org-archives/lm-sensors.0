From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 15 Mar 2007 15:56:41 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <4dfa50520703150856u3b7af037o43fa73590af09f43@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On 3/12/07, Jean Delvare <khali at linux-fr.org> wrote:
> The upper-case strings refer to device names, the lower-case strings
> refer to chip prefix as expected by libsensors. They are different
> things - as a matter of fact, we use prefix w83627eh_f_ the
> W83627EH_G_. It's convenient to use the same prefix for libsensors when
> two chips can be handled exactly the same way, but it is still valuable
> to print the exact chip name in the logs for debugging/support
> purposes.
>
> In my w83627hf patch, I've made the upper-case strings __initdata so
> they are removed from memory after driver initialization.
>
> There's nothing which can actually fail in w83627ehf_remove, so what
> would we do with "err"?
>
>
> Unified error paths are considered a good practice.

Thanks for the explanation, Jean. Sounds good to me. I'm swamped at
work this week, but I could still at least do a quick test of a patch.
However, I think I've lost track of this discussion. Sorry! Rudolf,
let me know if there's a patch you would like me to test. With luck, I
can run it on both the EHF and DHG on Saturday.

David

