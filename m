From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 04 Oct 2006 13:00:35 +0000
Subject: [lm-sensors] Analog Devices ADT7463
Message-Id: <20061004150035.73afdf9e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451D19F1.5060304@enib.fr>
In-Reply-To: <451D19F1.5060304@enib.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Firas,

> It is not listed in the Devices page and indeed, sensors-detect detects 
> only my GPU chip. I have an ADT7463 on my Asus A6JM laptop. Are there 
> any plans to add support for it ? Unfortunately, I'm not very skilled in 
> programming so I won't be able to help much but I'd be OK for doing some 
> testing.

The ADT7463 _is_ listed on our Devices page, it's supported by the lm85
driver for a long time now.

If sensors-detect didn't find it, it's most probably because Asus
disabled the SMBus on this laptop as they often do. In order to
reenable it, a PCI quick is needed. Please provide the output of "lspci
-vn". Note that this PCI quirk is mutually exclusive with suspend
support though, so if you want to be able to suspend and resume your
laptop, you can't have hardware monitoring support (other than the ACPI
temperature.)

-- 
Jean Delvare

