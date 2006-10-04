From: fkraiem@enib.fr (Firas Kraiem)
Date: Wed, 04 Oct 2006 15:59:46 +0000
Subject: [lm-sensors] Analog Devices ADT7463
Message-Id: <4523DA72.1090001@enib.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <451D19F1.5060304@enib.fr>
In-Reply-To: <451D19F1.5060304@enib.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Firas,
>
>  
>
>
>The ADT7463 _is_ listed on our Devices page, it's supported by the lm85
>driver for a long time now.
>
>If sensors-detect didn't find it, it's most probably because Asus
>disabled the SMBus on this laptop as they often do. In order to
>reenable it, a PCI quick is needed. Please provide the output of "lspci
>-vn". Note that this PCI quirk is mutually exclusive with suspend
>support though, so if you want to be able to suspend and resume your
>laptop, you can't have hardware monitoring support (other than the ACPI
>temperature.)
>
>  
>
Oh damn, I'm an idiot ! Well, I'll try with the lm85 driver this evening 
when I'll be back home, I don't think the SMBus is disables since I get 
the sensors info in Windows using Everest. If that still doesn't work, 
I'll parovide the otput of lspci -vn. Thanks again for the support !

