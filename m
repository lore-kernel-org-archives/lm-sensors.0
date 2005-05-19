From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Supporting Hardware monitor for VIA chipsets
Message-Id: <20020522104525.B3066@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <369B0912E1F5D511ACA5003048222B7555BBFE@EXCHANGE2>
In-Reply-To: <369B0912E1F5D511ACA5003048222B7555BBFE@EXCHANGE2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, thanks for the email.  Right now, I think we support the
VT8233(A), but not yet the VT8231 nor the VT8235.  We could use your
help to get drivers written.  If you can, we'd appreciate you
submitting bus drivers (see kernel/busses/i2c-* for examples) to
integrate into the project.  We might also be able to find a developer
to help out, but we seem to be a bit thin with programmers right now.

Thanks!


Phil

On Tue, May 21, 2002 at 05:50:03PM +0800, JH Tseng wrote:
> 
> Hi Sir,
> 
> I am a software engineer in VIA Tech Inc. According to the status report in
> your web site, we find that there are not the sensor chip drivers for latest
> VIA south bridges such as the VT8231, VT8233(A) and VT8235. Therefore, I
> need your help or I can provide some HWs and information to you to
> co-develope/co-test the hardware monitor based on the VIA platform. I deeply
> appreciate you very much if you have any input.
> 
> Best regards
> 
> JH

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
