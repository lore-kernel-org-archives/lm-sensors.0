From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 16 May 2007 21:12:22 +0000
Subject: Re: [lm-sensors] hwmon K8 sensor in processor up to revision E.
Message-Id: <464B73B6.4080301@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070511014240.1a5bb02c.miknix@gmail.com>
In-Reply-To: <20070511014240.1a5bb02c.miknix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

My conclusion is: ACPI might measure temperature from the other end of the 
heatpipe, so this is possible. I tried to track the DSDT it calls SMM so I cant 
tell how it get the temperature.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
