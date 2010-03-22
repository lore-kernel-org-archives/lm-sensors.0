From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Mar 2010 14:44:16 +0000
Subject: Re: [lm-sensors] ASUS hacking
Message-Id: <20100322154416.30a16bc5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201003211915.o2LJFxpb002210@kahuna.this-is.my-place.org>
In-Reply-To: <201003211915.o2LJFxpb002210@kahuna.this-is.my-place.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 21 Mar 2010 15:15:59 -0400, foo@kahuna.this-is.my-place.org wrote:
> So.... you want to formula hack ate ASUS board formulas?
> The correct location for the ACPI compiler/disassembler is
> www.acpica.org/downloads/
> The Intel address mentioned is obsolete.

Link fixed, thanks. That being said this wiki page is essentially
obsolete as well... For these Asus boards, you want to use the
asus_atk0110 driver, and it does all the naming and scaling for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
