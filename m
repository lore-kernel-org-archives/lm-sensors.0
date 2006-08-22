From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 22 Aug 2006 21:08:34 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor - take2
Message-Id: <4dfa50520608221408t66aec67h58151b7f2aa5d652@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44EB67BB.5010604@sh.cvut.cz>
In-Reply-To: <44EB67BB.5010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On 8/22/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Hello Jean,
>
> This patch adds support for the temperature sensor(s) found in AMD K8 CPUs.
>
> Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
>
> All fixed & tested on quad CPU - dual dual core ;), please apply.

This line has me thinking...
+	u32 temp[2][2];		/* core, place */

AMD and Intel are both coming out with quad-core processors soon. Some
could be backward-compatible with existing dual-core sockets. In
addition, some servers have four sockets (quad processor, or 8-core,
etc.).

Maybe this array should be a little bigger? It will save you some
trouble later. If not, it's okay to ignore this message...

HTH,
David

