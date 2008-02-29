From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 29 Feb 2008 23:58:26 +0000
Subject: Re: [lm-sensors] [patch 1/1] hwmon: add 0x8c id for smsc47b397
Message-Id: <Pine.LNX.4.64.0802291756420.19553@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <847993120802290924m6b12567p964a17e080030889@mail.gmail.com>
In-Reply-To: <847993120802290924m6b12567p964a17e080030889@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Feb 2008, Craig Kelley wrote:
> +       case 0x85:
> +       case 0x8c:
> +               name = "SCH5317";
> +               break;

Minor style thing: would

        case 0x85:
                /* fall through */
        case 0x8c:
                name = "SCH5317";
                break;

be clearer?

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
