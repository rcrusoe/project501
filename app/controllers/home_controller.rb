class HomeController < ApplicationController
    skip_before_action :authenticate_user!

    def invite
        @organizations = [
            [
                "Org Name",
                "Org Description",
                "http://www.google.com"
            ],
            [
                "Org Name 2",
                "Org Description 2",
                "http://www.google.com"
            ]
        ]
    end
end
