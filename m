From: charless.fowlkes@gmail.com (Charless Fowlkes)
Date: Thu, 10 Nov 2005 19:59:24 +0000
Subject: [lm-sensors] iwill versus w83627thf
Message-Id: <c3d94a2d0511101057g31898c55ya014c2c38cc8c322@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
In-Reply-To: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/9/05, Rudolf Marek <r.marek@sh.cvut.cz> wrote:
>
>
> It's caused by PNPACPI since 2.6.10,
> and has been fixed recently. See bug #4014 for additional information:
> http://bugzilla.kernel.org/show_bug.cgi?id@14
> If you don't want to upgrade kernels, the workaround is to disable
> PNPACPI, either when configuring your kernel or on the boot command line
> (pnpacpi=off).
>
> Let me know if you have any (other) problems,
>


an interesting thing...this motherboard (iwill zmaxdp) has two cpu
fans, one for each processor. it appears that the fan speed of
both is set to the max of their respective pwm settings on the
w83627thf.

this means that the probing performed by pwmconfig doesn't find
either fan since it only adjusts a single pwm setting at a time while
keeping the others set at their max value.

regards,
charless
