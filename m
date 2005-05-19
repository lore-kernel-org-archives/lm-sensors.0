From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <1089055829.32259.111.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 2004-07-05 at 19:22, Jean Delvare wrote:

> This simply proves that I misexpressed myself (though reading myself
> again I find it clear ;)). When I say "setting the critical limit should
> preserve the associated hysteresis limit", I mean that the user should
> not see it change, which precisely means that the register value should
> be updated. As a concrete example, let's consider that the critical
> limit is set to 80 degree and the hysteresis register holds 5. From the
> user's point of view, we have temp_crit=80 and temp_crit_hystu. Now if
> the user asks for temp_crit=85, it should *not* seem to affect
> temp_crit_hyst which should stay at 75, which means that the driver
> would have to both write 85 to crit register and 10 to hyst register. Is
> it clearer now?

Yes, it makes sense now. But I'm not sure how to handle the fact that
the hysteresis register applies to three temperature limits in the LM77.
Say, the register value for hysteresis is 2 degrees, T_crit=80,
T_high`. So the driver should show T_crit_hystx, T_high_hystX. Now
if the user changes T_crit to 90, T_crit_hyst should be still 78, so the
hysteresis register should hold 12 now. However that would mean that
T_high_hyst will show 68 now. Does it make sense? (I have doubts.) And
what if T_high is changed by the user? Should the hysteresis be updated
accordingly? Does that make sense? I don't think so, that would screw up
the hysteresis for T_crit. What is your suggestion?

Thanks,
Andras

