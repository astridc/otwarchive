@series
Feature: Create and Edit Series
  In order to view series created by a user
  As a reader
  The index needs to load properly, even for authors with more than ArchiveConfig.ITEMS_PER_PAGE series

  @disable_caching
  Scenario: Three ways to add a work to a series
    Given the following activated user exists
      | login         | password   |
      | author        | password   |
      And a warning exists with name: "Choose Not To Use Archive Warnings", canonical: true
      And the default ratings exist
    When I am logged in as "author" with password "password"
      And I go to the new work page
      And I select "Not Rated" from "Rating"
      And I check "Choose Not To Use Archive Warnings"
      And I fill in "Fandoms" with "My Little Pony"
      And I check "series-options-show"
      And I fill in "work_series_attributes_title" with "Ponies"
      And I fill in "Work Title" with "Sweetie Belle"
      And I fill in "content" with "First little pony is all alone"
      And I press "Preview"
    Then I should see "Part 1 of the Ponies series"
      And I should see "Draft was successfully created"
    When I press "Post"
    Then I should see "Work was successfully posted"
      And I should see "Part 1 of the Ponies series" within "div#series"
      And I should see "Part 1 of the Ponies series" within "dd.series"
    When I view the series "Ponies"
    Then I should see "Sweetie Belle"
    When I go to the new work page
      And I select "Not Rated" from "Rating"
      And I check "Choose Not To Use Archive Warnings"
      And I fill in "Fandoms" with "My Little Pony"
      And I select "Ponies" from "work_series_attributes_id"
      And I fill in "Work Title" with "Starsong"
      And I fill in "content" with "Second little pony want to make friends"
      And I press "Preview"
    Then I should see "Part 2 of the Ponies series"
    When I press "Post"
      And I view the series "Ponies"
    Then I should see "Sweetie Belle"
      And I should see "Starsong"
    When I go to the new work page
      And I select "Not Rated" from "Rating"
      And I check "Choose Not To Use Archive Warnings"
      And I fill in "Fandoms" with "My Little Pony"
      And I fill in "Work Title" with "Rainbow Dash"
      And I fill in "content" with "Third little pony is a little shy"
      And I press "Preview"
      And I press "Post"
    When I view the series "Ponies"
    Then I should not see "Rainbow Dash"
    When I edit the work "Rainbow Dash"
      And I select "Ponies" from "work_series_attributes_id"
      And I press "Preview"
      And I press "Update"
      And I view the series "Ponies"
      And I follow "Rainbow Dash"
    Then I should see "Part 3 of the Ponies series"
    When I follow "«"
    Then I should see "Starsong"
    When I follow "«"
    Then I should see "Sweetie Belle"
    When I follow "»"
    Then I should see "Starsong"
    When I view the series "Ponies"
      And I follow "Edit Series"
      And I fill in "Series Description" with "This is a series about ponies. Of course"
      And I fill in "Series Notes" with "I wrote this under the influence of coffee! And pink chocolate."
      And I press "Update"
    Then I should see "Series was successfully updated."
      And I should see "This is a series about ponies. Of course" within "blockquote.userstuff"
      And I should see "I wrote this under the influence of coffee! And pink chocolate." within "dl.series"
      And I should see "Complete: No"
    When I follow "Edit Series"
      And I check "series_complete"
      And I press "Update"
    Then I should see "Complete: Yes"
    When I edit the work "Rainbow Dash"
    Then the "series-options-show" checkbox should be checked
      And I should see "Ponies" within "fieldset#series-options"
    When I fill in "work_series_attributes_title" with "Black Beauty"
      And all search indexes are updated
      And I press "Preview"
    Then I should see "Part 3 of the Ponies series" within "dd.series"
    # TODO fix issue 3461 (manifests when perform_caching: true)
      # And I should see "Part 1 of the Black Beauty series" within "dd.series"
    When I press "Update"
      And all search indexes are updated
    Then I should see "Part 1 of the Black Beauty series" within "dd.series"
      And I should see "Part 3 of the Ponies series" within "dd.series"
      And I should see "Part 1 of the Black Beauty series" within "div#series"
      And I should see "Part 3 of the Ponies series" within "div#series"

  @disable_caching
  Scenario: Three ways to add a work to a series: a user with more than one pseud
    Given the following activated user exists
      | login         | password   |
      | author        | password   |
      And a warning exists with name: "Choose Not To Use Archive Warnings", canonical: true
      And the default ratings exist
    When I am logged in as "author" with password "password"
      And "author" creates the default pseud "Pointless Pseud"
    When I go to the new work page
      And I select "Not Rated" from "Rating"
      And I check "Choose Not To Use Archive Warnings"
      And I fill in "Fandoms" with "My Little Pony"
      And I select "Pointless Pseud" from "work_author_attributes_ids_"
      And I check "series-options-show"
      And I fill in "work_series_attributes_title" with "Ponies"
      And I fill in "Work Title" with "Sweetie Belle"
      And I fill in "content" with "First little pony is all alone"
      And I press "Preview"
    Then I should see "Part 1 of the Ponies series"
      And I should see "Draft was successfully created"
    When I press "Post"
    Then I should see "Work was successfully posted"
      And I should see "Pointless Pseud"
      And I should see "Part 1 of the Ponies series" within "div#series"
      And I should see "Part 1 of the Ponies series" within "dd.series"
    When I view the series "Ponies"
    Then I should see "Sweetie Belle"
    When I go to the new work page
      And I select "Not Rated" from "Rating"
      And I check "Choose Not To Use Archive Warnings"
      And I fill in "Fandoms" with "My Little Pony"
      And I select "Ponies" from "work_series_attributes_id"
      And I fill in "Work Title" with "Starsong"
      And I fill in "content" with "Second little pony want to make friends"
      And I press "Preview"
    Then I should see "Part 2 of the Ponies series"
    When I press "Post"
      And I view the series "Ponies"
    Then I should see "Sweetie Belle"
      And I should see "Starsong"
    When I go to the new work page
      And I select "Not Rated" from "Rating"
      And I check "Choose Not To Use Archive Warnings"
      And I fill in "Fandoms" with "My Little Pony"
      And I fill in "Work Title" with "Rainbow Dash"
      And I fill in "content" with "Third little pony is a little shy"
      And I press "Preview"
      And I press "Post"
    When I view the series "Ponies"
    Then I should not see "Rainbow Dash"
    When I edit the work "Rainbow Dash"
      And I select "Ponies" from "work_series_attributes_id"
      And I press "Preview"
      And I press "Update"
      And I view the series "Ponies"
      And I follow "Rainbow Dash"
    Then I should see "Part 3 of the Ponies series"
    When I follow "«"
    Then I should see "Starsong"
    When I follow "«"
    Then I should see "Sweetie Belle"
    When I follow "»"
    Then I should see "Starsong"
    When I view the series "Ponies"
      And I follow "Edit Series"
      And I fill in "Series Description" with "This is a series about ponies. Of course"
      And I fill in "Series Notes" with "I wrote this under the influence of coffee! And pink chocolate."
      And I press "Update"
    Then I should see "Series was successfully updated."
      And I should see "This is a series about ponies. Of course" within "blockquote.userstuff"
      And I should see "I wrote this under the influence of coffee! And pink chocolate." within "dl.series"
      And I should see "Complete: No"
    When I follow "Edit Series"
      And I check "series_complete"
      And I press "Update"
    Then I should see "Complete: Yes"
    When I edit the work "Rainbow Dash"
    Then the "series-options-show" checkbox should be checked
      And I should see "Ponies" within "fieldset#series-options"
    When I fill in "work_series_attributes_title" with "Black Beauty"
      And I press "Preview"
    Then I should see "Part 3 of the Ponies series" within "dd.series"
    # TODO fix issue 3461 (manifests when perform_caching: true)
      # And I should see "Part 1 of the Black Beauty series" within "dd.series"
    When I press "Update"
    Then I should see "Part 1 of the Black Beauty series" within "dd.series"
      And I should see "Part 3 of the Ponies series" within "dd.series"
      And I should see "Part 1 of the Black Beauty series" within "div#series"
      And I should see "Part 3 of the Ponies series" within "div#series"

  @disable_caching
  Scenario: Rename a series
    Given I am logged in as a random user
    When I add the work "WALL-E" to series "Robots"
    Then I should see "Part 1 of the Robots series" within "div#series"
      And I should see "Part 1 of the Robots series" within "dd.series"
    When I view the series "Robots"
      And I follow "Edit Series"
      And I fill in "Series Title" with "Many a Robot"
      And I press "Update"
    Then I should see "Series was successfully updated."
      And I should see "Many a Robot"
    When I view the work "WALL-E"
      Then I should see "Part 1 of the Many a Robot series" within "div#series"
    And "AO3-3847" is fixed
    #  And I should see "Part 1 of the Many a Robot series" within "dd.series"

  Scenario: Post Without Preview
    Given I am logged in as "whoever" with password "whatever"
      And I add the work "public" to series "be_public"
      And I follow "be_public"
    Then I should not see the image "title" text "Restricted" within "h2"

  Scenario: View user's series index

    Given I am logged in as "whoever" with password "whatever"
      And I add the work "grumble" to series "polarbears"
    When I go to whoever's series page
    Then I should see "whoever's Series"
      And I should see "polarbears"

  Scenario: Series index for maaany series
    Given I am logged in as "whoever" with password "whatever"  
      And I add the work "grumble" to "32" series "penguins"
    When I go to whoever's series page
    Then I should see "penguins30"
    When I follow "Next"
    Then I should see "penguins0"
  
  Scenario: Delete a series
    Given I am logged in as "cereal" with password "yumyummy"
      And I add the work "Snap" to series "Krispies"
    When I view the series "Krispies"
      And I follow "Delete Series"
      And I press "Yes, Delete Series"
    Then I should see "Series was successfully deleted."
