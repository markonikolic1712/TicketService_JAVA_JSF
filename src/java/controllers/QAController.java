package controllers;

import beans.Operator;
import beans.Question;
import beans.QuestionAssociation;
import beans.Ticket;
import beans.TicketType;
import beans.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.ExternalContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.primefaces.context.RequestContext;

@ManagedBean
@SessionScoped
public class QAController {

    private List<QuestionAssociation> allQA;
    private List<Question> allQuestions;
    private List<Question> allLastQuestions;
    private int idTicketType;
    private String subject;
    private int idFirstQ;
    private int idSecondQ;
    private Question question1;
    private Question question2;
    private String answer;
    private int idThirdQ;
    private String newAnswer;
    private boolean visibleManageDialog;

    public List<Question> getAllLastQuestions() {
        return allLastQuestions;
    }

    public void setAllLastQuestions(List<Question> allLastQuestions) {
        this.allLastQuestions = allLastQuestions;
    }

    public boolean isVisibleManageDialog() {
        return visibleManageDialog;
    }

    public void setVisibleManageDialog(boolean visibleManageDialog) {
        this.visibleManageDialog = visibleManageDialog;
    }

    public String getNewAnswer() {
        return newAnswer;
    }

    public void setNewAnswer(String newAnswer) {
        this.newAnswer = newAnswer;
    }

    public int getIdThirdQ() {
        return idThirdQ;
    }

    public void setIdThirdQ(int idThirdQ) {
        this.idThirdQ = idThirdQ;
    }

    public Question getQuestion1() {
        return question1;
    }

    public void setQuestion1(Question question1) {
        this.question1 = question1;
    }

    public Question getQuestion2() {
        return question2;
    }

    public void setQuestion2(Question question2) {
        this.question2 = question2;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public int getIdFirstQ() {
        return idFirstQ;
    }

    public void setIdFirstQ(int idFirstQ) {
        this.idFirstQ = idFirstQ;
    }

    public int getIdSecondQ() {
        return idSecondQ;
    }

    public void setIdSecondQ(int idSecondQ) {
        this.idSecondQ = idSecondQ;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getIdTicketType() {
        return idTicketType;
    }

    public void setIdTicketType(int idTicketType) {
        this.idTicketType = idTicketType;
    }

    public List<QuestionAssociation> getAllQA() {
        return allQA;
    }

    public void setAllQA(List<QuestionAssociation> allQA) {
        this.allQA = allQA;
    }

    public List<Question> getAllQuestions() {
        return allQuestions;
    }

    public void setAllQuestions(List<Question> allQuestions) {
        this.allQuestions = allQuestions;
    }

    public Question getQuestionForId(int id) {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from questions where id_questions =" + id);

            if (rs.next()) {
                Question q = new Question();
                q.setIdQuestion(id);
                q.setSubject(rs.getString("question"));
                return q;
            }

        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String getQuestionSubjectForId(int id, Question question2) {
        if (id == 0) {
            return "";
        } else if (question2 == null) {
            return "";
        }
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from questions where id_questions =" + id);

            if (rs.next()) {
                String subject = rs.getString("question");
                return subject;
            }

        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
    }

    public List<Question> takeAllQuestions() {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from questions");
            allQuestions = new ArrayList<>();
            while (rs.next()) {
                Question q = new Question();
                int idQ = rs.getInt("id_questions");
                String question = rs.getString("question");
                q.setIdQuestion(idQ);
                q.setSubject(question);
                allQuestions.add(q);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<QuestionAssociation> takeAllQAForType() {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from question_associations where fk_id_ticket_type =" + idTicketType);
            allQA = new ArrayList<>();
            while (rs.next()) {
                QuestionAssociation qa = new QuestionAssociation();
                int idq1 = rs.getInt("id_question1");
                Integer idq2 = rs.getInt("id_question2");
                qa.setAnswer(rs.getString("answer"));
                qa.setFk_id_ticket_type(idTicketType);
                Question q1 = getQuestionForId(idq1);
                Question q2 = getQuestionForId(idq2);
                if (q2 == null) {
                    qa.setRenderEdit(false);
                    qa.setRenderedOutputMenu(true);
                    qa.setSecondQuestion(null);
                } else {
                    qa.setRenderEdit(true);
                    qa.setRenderedOutput(true);
                    qa.setSecondQuestion(q2);
                }
                qa.setFirstQuestion(q1);
                allQA.add(qa);
            }
            return allQA;
        } catch (SQLException ex) {
            Logger.getLogger(CityController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void openTable() {
        takeAllQAForType();
        takeAllQuestions();
        setVisibleManageDialog(true);
        RequestContext.getCurrentInstance().execute("PF('manageQuestionsDialog').show()");
    }

    public Boolean firstQuestionExists() {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from first_questions where fk_idticket_type =" + idTicketType);
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void reload() throws IOException {
        ExternalContext ec = FacesContext.getCurrentInstance().getExternalContext();
        ec.redirect(((HttpServletRequest) ec.getRequest()).getRequestURI());
    }

    public void renderInsertQuestion() {
        if (firstQuestionExists()) {
            RequestContext.getCurrentInstance().execute("PF('firstQuestionExistsDialog').show()");
        } else if (allQuestions.size() == 0) {
            RequestContext.getCurrentInstance().execute("PF('noQuestionsDialog').show()");
        } else {
            RequestContext.getCurrentInstance().execute("PF('insertQuestionDialog').show()");
        }
    }

    public void insertQuestionInDatabase() {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            String query = "insert into questions (question) values(?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, subject);
            ps.executeUpdate();
            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "Question Added", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            clear();
        }
    }

    public void insertQuestionInAssociations(int idQ) {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            String query = "insert into question_associations (id_question1, id_question2, answer, fk_id_ticket_type) values (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, idQ);
            ps.setObject(2, null);
            ps.setString(3, "Yes");
            ps.setInt(4, idTicketType);
            ps.executeUpdate();
            ps.setInt(1, idQ);
            ps.setObject(2, null);
            ps.setString(3, "No");
            ps.setInt(4, idTicketType);
            ps.executeUpdate();
            ps.setInt(1, idQ);
            ps.setObject(2, null);
            ps.setString(3, "Maybe");
            ps.setInt(4, idTicketType);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Boolean hasPrimaryKey(int id, String answer) {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            String query = "select * from question_associations where id_question1 =" + id + " and answer = \"" + answer + "\"";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertQuestionInAssociations() {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            String query = "insert into question_associations (id_question1, id_question2, answer, fk_id_ticket_type) values (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, idThirdQ);
            ps.setInt(2, question2.getIdQuestion());
            ps.setString(3, newAnswer);
            ps.setInt(4, idTicketType);
            ps.executeUpdate();
            if (!newAnswer.equals("Yes") && !hasPrimaryKey(idThirdQ, "Yes")) {
                ps.setInt(1, idThirdQ);
                ps.setObject(2, null);
                ps.setString(3, "Yes");
                ps.setInt(4, idTicketType);
                ps.executeUpdate();
            }
            if (!newAnswer.equals("No") && !hasPrimaryKey(idThirdQ, "No")) {
                ps.setInt(1, idThirdQ);
                ps.setObject(2, null);
                ps.setString(3, "No");
                ps.setInt(4, idTicketType);
                ps.executeUpdate();
            }
            if (!newAnswer.equals("Maybe") && !hasPrimaryKey(idThirdQ, "Maybe")) {
                ps.setInt(1, idThirdQ);
                ps.setObject(2, null);
                ps.setString(3, "Maybe");
                ps.setInt(4, idTicketType);
                ps.executeUpdate();
            }

        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertLinkedQuestion(int idQ1, String answer, int idQ2) throws IOException {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            String query = "update question_associations set id_question2 =" + idQ2 + " where id_question1 = " + idQ1 + " and answer = \"" + answer + "\"";
            stmt.executeUpdate(query);
            insertQuestionInAssociations(idQ2);
            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "Questions updated", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            takeAllQAForType();
            idSecondQ = 0;
            reload();
        }
    }

    public int getIdOfLastInsertedQuestion() {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            String query = "select * from questions order by id_questions desc limit 1";
            ResultSet rs = stmt.executeQuery(query);
            int idQ = 0;
            if (rs.next()) {
                idQ = rs.getInt("id_questions");
            }
            return idQ;
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public String insertFirstQuestion() {
        insertQuestionInAssociations(idFirstQ);
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            String query = "insert into first_questions (fk_id_questions, fk_idticket_type) values(?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, idFirstQ);
            ps.setInt(2, idTicketType);
            ps.executeUpdate();
            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "First Question Added", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            clear();
        }
        return "admin?faces-redirect=true";
    }

    public void updateQuestion(Question first, Question second) throws IOException {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();

            String query = "update questions set question='" + first.getSubject() + "' where id_questions= " + first.getIdQuestion();
            stmt.executeUpdate(query);
            query = "update questions set question='" + second.getSubject() + "' where id_questions= " + second.getIdQuestion();
            stmt.executeUpdate(query);

            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "Questions updated", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            takeAllQAForType();
            reload();
        }
    }

    public void renderInsertBetweenDialog(Question first, String answer1, Question second) {
        visibleManageDialog = false;
        question1 = first;
        answer = answer1;
        question2 = second;
        RequestContext.getCurrentInstance().execute("PF('insertBetweenDialog').show()");
    }

    public void clear() {
        idTicketType = 0;
        subject = "";
        idFirstQ = 0;
        idSecondQ = 0;
        idThirdQ = 0;
        newAnswer = "";
        answer = "";
        question1 = null;
        question2 = null;
    }

    public void insertBetweenQuestion() throws IOException {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            String query = "update question_associations set id_question2 = " + idThirdQ + " where id_question1 = " + question1.getIdQuestion() + " and answer = \"" + answer + "\"";
            stmt.executeUpdate(query);
            insertQuestionInAssociations();

            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "Question inserted", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            takeAllQAForType();
            reload();
            visibleManageDialog = true;
        }

    }

    public void closeManageDialog() throws IOException {
        visibleManageDialog = false;
        reload();
    }

    public Boolean isLastQuestion(int idQ, int idTT) {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            String query = "select * from question_associations where id_question1 = " + idQ + " and fk_id_ticket_type =" + idTT;
            ResultSet rs = stmt.executeQuery(query);
            boolean last = false;
            if (rs.next()) {
                last = true;
                int idQ2 = rs.getInt("id_question2");
                if (idQ2 != 0) {
                    last = false;
                }
                while (rs.next()) {
                    idQ2 = rs.getInt("id_question2");
                    if (idQ2 != 0) {
                        last = false;
                    }
                }
            }

            return last;
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void takeAllLastQuestions() {
        allLastQuestions = new ArrayList<>();
        for (int i = 0; i < allQuestions.size(); i++) {
            if (isLastQuestion(allQuestions.get(i).getIdQuestion(), idTicketType)) {
                allLastQuestions.add(allQuestions.get(i));
            }
        }
    }

    public void renderDeleteQuestion() {
        takeAllLastQuestions();
        if (allLastQuestions.size() == 0) {
            RequestContext.getCurrentInstance().execute("PF('noQuestionsDialog').show()");
        } else {

            RequestContext.getCurrentInstance().execute("PF('deleteQuestionDialog').show()");
        }
    }

    public Boolean isFirstQuestion(int idQ) {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            String query = "select * from first_questions where fk_id_questions = " + idQ;
            ResultSet rs = stmt.executeQuery(query);
            boolean first = false;
            if (rs.next()) {
                first = true;
            }

            return first;
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteQuestion() throws IOException {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("delete from question_associations where id_question1 = " + idFirstQ);
            if (isFirstQuestion(idFirstQ)) {
                stmt.executeUpdate("delete from first_questions where fk_id_questions = " + idFirstQ);
            }
            stmt.executeUpdate("delete from questions where id_questions = " + idFirstQ);

            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "Question deleted", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            clear();
            reload();
        }
    }

    public void deleteLastQuestion(int idQ1, String answer1, Integer idQ2) throws IOException {
        try {
            Connection conn = DriverManager.getConnection(db.DB.connectionString, db.DB.user, db.DB.password);
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("delete from question_associations where id_question1 = " + idQ2);
            stmt.executeUpdate("update question_associations set id_question2 = null where id_question1 = " + idQ1 + " and answer = \"" + answer1 + "\"");
            FacesContext context = FacesContext.getCurrentInstance();
            context.getExternalContext().getFlash().setKeepMessages(true);
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO, "Question deleted", null);
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (SQLException ex) {
            Logger.getLogger(QAController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            takeAllQAForType();
            reload();
        }
    }
    
    public void cancel() throws IOException {
        reload();
        visibleManageDialog = true;
        takeAllQAForType();
        idSecondQ = 0;
    }
}