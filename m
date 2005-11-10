From: charless.fowlkes@gmail.com (Charless Fowlkes)
Date: Thu, 10 Nov 2005 07:57:16 +0000
Subject: [lm-sensors] iwill versus w83627thf
Message-Id: <c3d94a2d0511092256v430a2fe3t178a392d996e9433@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
In-Reply-To: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thank you! this workaround worked.

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
