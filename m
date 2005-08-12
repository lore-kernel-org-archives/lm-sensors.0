From: jcromie@divsol.com (Jim Cromie)
Date: Fri, 12 Aug 2005 17:43:00 +0000
Subject: [lm-sensors] pc87360  voltage reference constants
Message-Id: <42FCC357.1000802@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hi Jean, etal,

Im looking to understand why my temps are so high,
esp in comparison to values from my soekris as obtained from
http://phk.freebsd.dk/soekris/env4801/

    VREF = 1.214  V245 = 2.450
    Temp 2 (status=0x81)   54 C

in your code,

        data->in_vref = (i&0x02) ? 3025 : 2966;
        dev_dbg(&new_client->dev, "Using %s reference voltage\n",
            (i&0x02) ? "external" : "internal");

youve got 2 magical constants,  where are they from ?
I cant find mention of them in the pdf, but theyre/its used to scale
the voltages read by show_in_input()

    return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
               data->in_vref));

#define IN_FROM_REG(val,ref)        (((val) * (ref) + 128) / 256)



I think my temp answers lie elsewhere (perhaps a cast to s8 for the 
register value),
but Im hoping your answer wrt the constants will clarify some stuff.

tia
jimc

BTW, (since Im writing),  my patchset for pc87366 sensors-dev-attrs
(done against rc4-mm1), also applies (clean, iirc) to rc5-mm1, and works 
there.
