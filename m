From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 04 Nov 2005 20:57:17 +0000
Subject: [lm-sensors] as99127f rev2.0
Message-Id: <436BBCE8.9090405@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1130931549.9178.9.camel@localhost>
In-Reply-To: <1130931549.9178.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

stein wrote:
> hi all, i'm currently working on a asus cuv4x-dls motherboard with a
> as99127f chip on the i?c bus..
> 
> currently i can snoop my i?c bus thruogh another pc, and have an asus
> i-panel.. 
> 
> i'm able to control the fan speend trough the 0x59 register with values
> like 0x8?h
> where 0x8F is full speed, 
>       0x8E is slightly lower
>        ...    ...
> 0x8A is what the asus control panel (software) uses for low speed.. 
> altough 0x89 also works (more slow..)


Hello,

If you find anything useful, feel free to update the documentation of the chip which is either in lm_sensors package
in file w83781d or in 2.6 kernel tree linux-2.6.x/Documentation/hwmon/w83781d

Patch is wellcomed.

Thanks

Regards
Rudolf
