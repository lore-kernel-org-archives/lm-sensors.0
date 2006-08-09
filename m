From: johannes@sipsolutions.net (Johannes Berg)
Date: Wed, 09 Aug 2006 12:25:03 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <44D9D41F.8050402@sipsolutions.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael Hanselmann wrote:
> I'm not really a fan of it. Is there anything wrong with my proposed
> patch?
>   
This is what you get if I write things and then don't put the powerbook 
online for days.

I think your depends statement is hard to parse, but should be fine :) 
Try actually configuring things in the presence of I2C=m though, please.

johannes

