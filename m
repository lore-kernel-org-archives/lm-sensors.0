From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 23 May 2006 07:13:20 +0000
Subject: [lm-sensors] Question about correct sensor
Message-Id: <4472B610.3030003@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
In-Reply-To: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Christoph,

> I'm using a Asus P5WD2 with a Intel 955X Northbride and a ICH7R 
> Southbridge. It seems I can't find the correct sensors driver for this 
> chipset.
> 
> Can anybody of you help?

Yes we can, although this is RTFM question.

-1) RTFM
0) get the lm-sensors package from your distribution or from our web site
1) install it
2) if you compiled your own kernel make sure you have i2c-i801 driver ready
3) run sensors-detect as root
4) this script should tell you what chips you have
5) if you have your own kernel compile missing drivers
6) modprobe the drivers that sensors-detect suggest
7) run the sensors command
8) adjust /etc/sensors.conf to your needs

If you no sensors are detected please send us output of sensors detect.


> This email is confidential and may also be legally privileged.
> If you have received this email in error, you are in notice of
> its status.

Well it is transmitted unencrypted and also to public mailing list


> Please notify the sender immediately by reply
> e-mail and then delete this message from your system. Please
> do not copy or use it for any purposes, or disclose its contents
> to any other person: to do so could be a breach of confidence.
> Thank you for your co-operation.

Hmm quite irrelevant here

 > Any views expressed in this message are those of the individual
> sender and may not necessarily reflect the views of
> TI.KOM Tirol Kommunikation GmbH.

lol

Please can you remove such message in your future mails? I know that this might
be a company policy but it may annoy people round here, so better to avoid such
disclaimers or large footers.

In my job we solved it with special developer mailing list footer :)

Regards
Rudolf

