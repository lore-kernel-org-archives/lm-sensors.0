From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 20 Sep 2006 19:36:25 +0000
Subject: [lm-sensors] Module(s) ALI15** not loading
Message-Id: <45119839.2010100@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158188393.9914.5.camel@localhost.localdomain>
In-Reply-To: <1158188393.9914.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alejandro Riveira Fern?ndez wrote:
>         Hi I have changed my mobo, now i have an uli1697 based asrock
>         AM2xli-esataII 
>         
>         i'm seeing this in the dmesg
>         
>         ali1535_smbus 0000:00:15.1: ALI1535_smb region uninitialized - upgrade BIOS?
>         ali1535_smbus 0000:00:15.1: ALI1535 not detected, module not inserted.
>         ali15x3_smbus 0000:00:15.1: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr
>         ali15x3_smbus 0000:00:15.1: ALI15X3 not detected, module not inserted.
>         
>         ??Does anybody has an idea of how to make it work?

Not yet. Please provide output of following (you need to to be root)
lspci -xxx
sensors-detect

(with newest sensors-detect - 
http://www.lm-sensors.org/wiki/iwizard/NoSensorsDetected

Regards
Rudolf

