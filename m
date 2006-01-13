From: marcus@quintic.co.uk (Marcus Williams)
Date: Fri, 13 Jan 2006 09:27:14 +0000
Subject: [lm-sensors] Incorrect SiS chipset detection?
Message-Id: <43C77272.8070009@quintic.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <43C6762C.3040001@quintic.co.uk>
In-Reply-To: <43C6762C.3040001@quintic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 13/01/2006 Mark M. Hoffman wrote:
[snip]
> The above output looks OK.  You still need to edit /etc/sensors.conf
> to taste and then run 'sensors -s'.  Please read the FAQ.

Thanks at least thats reassuring!

> Could you please send the output from 'lspci -n' ?

0000:00:00.0 0600: 1039:0661 (rev 11)
0000:00:01.0 0604: 1039:0003
0000:00:02.0 0601: 1039:0008 (rev 25)
0000:00:02.5 0101: 1039:5513
0000:00:03.0 0c03: 1039:7001 (rev 0f)
0000:00:03.1 0c03: 1039:7001 (rev 0f)
0000:00:03.3 0c03: 1039:7002
0000:00:04.0 0200: 1039:0900 (rev 90)
0000:01:00.0 0300: 1039:6330

This is a remote box so I cant get to the BIOS without getting an 
engineer to take a look, but it hasnt got anything important on it 
(mainly because I dont trust it until I've sorted this heat problem out) 
so if I can test anything email me.

Cheers

Marcus

-- 
Marcus Williams -- http://www.cad-schroer.co.uk
CAD Schroer UK, 39 Newnham Road, Cambridge, UK

