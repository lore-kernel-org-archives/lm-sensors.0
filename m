From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 23 Jan 2006 08:09:03 +0000
Subject: [lm-sensors] support for Soyo motherboard
Message-Id: <43D48F1F.7020502@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY107-F32A65DEB24FE12F9BBA109AC110@phx.gbl>
In-Reply-To: <BAY107-F32A65DEB24FE12F9BBA109AC110@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Any ideas?

Yes. This is because there were some troubles between ACPI PNP  IO region size and drivers IO region size.
You have older system so you should pass pnpacpi=off to kernel as an boot option.

I think this will fix it.
Regards
Rudolf

