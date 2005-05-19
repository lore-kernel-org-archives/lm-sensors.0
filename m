From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 reset option
Message-Id: <20040229091841.461847f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228183508.200a8655.komoriya@paken.org>
In-Reply-To: <20040228183508.200a8655.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replying to myself.

> > +		tmp = (tmp & 0xc0) | 0x2a;
> > +		it87_write_value(client, IT87_REG_TEMP_ENABLE, tmp);
> > +	}
> > +	data->sensor = tmp;
> 
> I don't think this is needed. That value will be updated in
> it87_update_client, and this function will be called at least once
> before you access data->sensor again.

I'm wrong here. The line is indeed required, in case someone tries to
set the sensor types from user-space before reading anything from the
chip (and this is very likely to happen since we encourage people to run
"sensors -s" right after loading the modules).

So sorry (again...) for the noise. Still my two other remarks make
sense...

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
