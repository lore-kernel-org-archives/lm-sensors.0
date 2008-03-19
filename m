From: "Frank Phillips" <frankalso@gmail.com>
Date: Wed, 19 Mar 2008 16:45:10 +0000
Subject: Re: [lm-sensors] Strange temperature values
Message-Id: <78171f0a0803190945j2bbb3e2era1d87c8d027b1b94@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47DFA4D2.1060009@givemefish.com>
In-Reply-To: <47DFA4D2.1060009@givemefish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 18, 2008 at 8:06 PM, Matt Roberds <mattroberds@cox.net> wrote:
>  > # sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)
>
>  The latest version of sensors-detect is "5108 (2008-01-22 13:22:47
>  +0100)"; you may get better results from a newer version of the
>  complete lm-sensors package if possible.

Do you have the coretemp module loaded (kernels >= 2.6.22)? It
accesses the temp sensor on Core/Core 2 processors. You will need a
newer lm-sensors to take advantage of coretemp.

You can also get useful information from the IPMI BMC with ipmitool,
for example. In my experience, it will only give you the cpu "thermal
margin," though.

Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
