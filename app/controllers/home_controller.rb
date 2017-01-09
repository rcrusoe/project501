class HomeController < ApplicationController
    skip_before_action :authenticate_user!

    def invite
        @organizations = [
            [
                "Planned Parenthood",
                "Provides reproductive health services and abortion services to millions of women.",
                "Women’s Rights",
                "https://www.plannedparenthood.org"
            ],
            [
                "The Center for Reproductive Rights",
                "Legal advocate for securing access to quality reproductive health care.",
                "Women’s Rights",
                "https://www.reproductiverights.org"
            ],
            [
                "Natural Resources Defense Council",
                "Brings together scientists, lawyers, and policy experts to support environmental protection.",
                "Climate Change",
                "https://www.nrdc.org"
            ],
            [
                "Greenpeace",
                "Researches and lobbies for environmental protection.",
                "Climate Change",
                "http://www.greenpeace.org/"
            ],
            [
                "The National Immigration Law Center",
                "Defends the rights of low-income immigrants.",
                "Immigration",
                "https://www.nilc.org/"
            ],
            [
                "The Human Rights Campaign",
                "The nation's largest LGBTQ rights organization.",
                "LGBT Equality and Support",
                "http://www.hrc.org/"
            ],
            [
                "The Trevor Project",
                "Focuses on suicide prevention among members of the LGBTQ community.",
                "LGBT Equality and Support",
                "http://www.thetrevorproject.org/"
            ],
            [
                "The American Civil Liberties Union",
                "Provides legal assistance in cases in which civil liberties are at risk",
                "Civil Rights",
                "https://www.aclu.org/"
            ],
            [
                "The Southern Poverty Law Center",
                "Legal defense of the civil rights of minorities, prisoners, and the LGBT community",
                "Civil Rights",
                "https://www.splcenter.org/"
            ],
            [
                "Lambda Legal",
                "Legal organization dedicated to fighting for the rights of the LGBTQ community and Americans living with HIV",
                "LGBT Equality and Support",
                "http://www.lambdalegal.org/"
            ],
            [
                "National Association for the Advancement of Colored People",
                "Fighting for both the rights of African Americans and against racial prejudice",
                "Civil Rights",
                "http://www.naacp.org/"
            ],
            [
                "Council on American-Islamic Relations ",
                "Muslim civil-rights advocacy group dedicated to promoting a positive image of Islam and Muslims in the United States",
                "Civil Rights",
                "https://www.cair.com/"
            ],
            [
                "Rape Abuse & Incest National Network",
                "An anti-sexual assault organization that works with local rape crisis centers across America",
                "Violence Against Women",
                "https://www.rainn.org"
            ],
            [
                "Stand With Standing Rock",
                "An organization committed to permanently halting the Dakota Access Pipeline",
                "Climate Change",
                "http://standwithstandingrock.net/"
            ],
            [
                "Americans for Immigrant Justice",
                "A non-profit law firm committed to protecting and fighting for the basic rights of immigrants",
                "Immigration",
                "http://www.aijustice.org/"
            ],
        ]
    end
end
