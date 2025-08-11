using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Portfolio_try_1
{
    // Simple Skill class for this page
    public class SkillData
    {
        public int SkillId { get; set; }
        public string SkillName { get; set; }
        public string SkillType { get; set; }
        public int Proficiency { get; set; }
    }

    public partial class Skills : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSkillsFromDatabase();
            }
        }

        private void LoadSkillsFromDatabase()
        {
            try
            {
                List<SkillData> skills = GetSkillsFromDatabase();
                GenerateSkillsHTML(skills);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Database Error: {ex.Message}");
                ShowErrorMessage($"Error: {ex.Message}");
            }
        }

        private List<SkillData> GetSkillsFromDatabase()
        {
            List<SkillData> skills = new List<SkillData>();
            string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT Skill_name, Skill_Type, Proficiency FROM Skills 
                ORDER BY 
                    CASE Skill_Type 
                        WHEN 'Language' THEN 1 
                        WHEN 'Framework' THEN 2 
                        WHEN 'Tool' THEN 3 
                        ELSE 4 
                    END, 
                    Proficiency DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        int skillId = 1;
                        while (reader.Read())
                        {
                            skills.Add(new SkillData
                            {
                                SkillId = skillId++,
                                SkillName = reader["Skill_name"].ToString(),
                                SkillType = reader["Skill_Type"].ToString(),
                                Proficiency = Convert.ToInt32(reader["Proficiency"])
                            });
                        }
                    }
                }
            }

            return skills;
        }

        private void GenerateSkillsHTML(List<SkillData> skills)
        {
            var groupedSkills = skills.GroupBy(s => s.SkillType).ToDictionary(g => g.Key, g => g.ToList());
            StringBuilder html = new StringBuilder();

            foreach (var category in groupedSkills)
            {
                string categoryTitle = GetCategoryTitle(category.Key);
                html.AppendLine("<div class='skill-category'>");
                html.AppendLine($"<h2>{categoryTitle}</h2>");
                html.AppendLine("<div class='skills-list'>");

                foreach (var skill in category.Value)
                {
                    html.AppendLine("<div class='skill-item'>");
                    html.AppendLine($"<span class='skill-name'>{skill.SkillName}</span>");
                    html.AppendLine("<div class='skill-bar'>");
                    html.AppendLine($"<div class='skill-progress' data-width='{skill.Proficiency}'></div>");
                    html.AppendLine("</div>");
                    html.AppendLine("</div>");
                }

                html.AppendLine("</div>");
                html.AppendLine("</div>");
            }

            skillsContainer.InnerHtml = html.ToString();
        }

        private string GetCategoryTitle(string skillType)
        {
            switch (skillType.ToLower())
            {
                case "Language":
                    return "Languages";
                
                case "tool":
                    return "Tools & Technologies";
               
                case "framework":
                    return "Frameworks & Libraries";
                default:
                    return skillType;
            }
        }

        private void ShowErrorMessage(string message)
        {
            skillsContainer.InnerHtml = $"<div style='text-align: center; padding: 2rem; color: red;'><h3>Error Loading Skills</h3><p>{message}</p></div>";
        }
    }
}