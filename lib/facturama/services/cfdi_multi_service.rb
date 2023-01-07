# frozen_string_literal: true

require_relative 'crud_service'
require 'base64'

module Facturama
  module Services
    class CfdiMultiService < CrudService
      def initialize(connection_info)
        super(connection_info, '')
      end

      # ------------------------ CRUD ------------------------

      # CFDI 3.3
      def create(model)
        post(model, 'api-lite/2/cfdis')
      end

      # CFDI 4.0
      def create3(model)
        post(model, 'api-lite/3/cfdis')
      end

      def remove(id, motive, uuidReplacement)
        motive = '02' if motive.nil? && motive != ''
        uuidReplacement = '' if uuidReplacement.nil? && uuidReplacement != ''

        raise(FacturamaException('El Id del cfdi a eliminar es obligatorio')) unless !id.nil? && id != ''

        delete("api-lite/cfdis/#{id}?motive=#{motive}&uuidReplacement=#{uuidReplacement}")
      end

      def retrieve(id)
        get("api-lite/cfdis/#{id}")
      end

      # ------------------------ DESCARGA DE ARCHIVOS (PDF, XML, HTML) ------------------------

      # Obtiene un archivo referente a un CFDI del tipo "Issued"
      # @param id Identificador del CFDI
      # @param format Formato deseado ( pdf | html | xml )
      # @param type Tipo de comprobante ( payroll | received | issued )
      # @return Archivo en cuestion
      def get_file(id, format, type)
        resource = "cfdi/#{format}/#{type}/#{id}"
        get(resource)
      end

      # Decodifica y guarda un archivo base64 en una ruta
      def save_file(file_path, file_content_base64)
        file_content_decoded = Base64.decode64(file_content_base64)
        File.open(file_path, 'wb') do |f|
          f.write(file_content_decoded)
        end
      end

      def save_pdf(file_path, id, type = Facturama::InvoiceType::ISSUED_LITE)
        file_content = get_file(id, Facturama::FileFormat::PDF, type)
        save_file(file_path, file_content['Content'])
      end

      def save_xml(file_path, id, type = Facturama::InvoiceType::ISSUED_LITE)
        file_content = get_file(id, Facturama::FileFormat::XML, type)
        save_file(file_path, file_content['Content'])
      end

      def save_html(file_path, id, type = Facturama::InvoiceType::ISSUED_LITE)
        file_content = get_file(id, Facturama::FileFormat::HTML, type)
        save_file(file_path, file_content['Content'])
      end

      # ------------------------ LISTADO DE CFDIS ------------------------

      # Listado de Cfdi filtrando por palabra clave
      def list_by_keyword(keyword,
                          status = Facturama::CfdiStatus::ACTIVE)

        resource = "api-lite/cfdis?status=#{status}&keyword=#{keyword}"
        get(resource)
      end

      # Listado de Cfdi filtrando por palabra RFC
      def list_by_rfc(rfc,
                      status = Facturama::CfdiStatus::ACTIVE,
                      _type = Facturama::InvoiceType::ISSUED)

        resource = "api-lite/cfdis?status=#{status}&rfc=#{rfc}"
        get(resource)
      end

      # Listado con todas las opciones posibles
      def list(folio_start = -1, folio_end = -1,
               rfc = nil,  tax_entity_name = nil,
               date_start = nil, date_end = nil,
               id_branch = nil,  serie = nil,
               status = Facturama::CfdiStatus::ACTIVE,
               type = Facturama::InvoiceType::ISSUED)

        resource = "api-lite/cfdis?type=#{type}&status=#{status}"

        resource += "&folioStart=#{folio_start}" if folio_start > -1

        resource += "&folioEnd=#{folio_end}" if folio_end > -1

        resource += "&rfc=#{rfc}" unless rfc.nil?

        resource += "&taxEntityName=#{tax_entity_name}" unless tax_entity_name.nil?

        resource += "&dateStart=#{date_start}" unless date_start.nil?

        resource += "&dateEnd=#{date_end}" unless date_end.nil?

        resource += "&idBranch=#{id_branch}" unless id_branch.nil?

        resource += "&serie=#{serie}" unless serie.nil?

        get(resource)
      end

      # ------------------------ ENVIO POR CORREO ------------------------

      # Envía el CFDI por correo, con el asunto especificado
      def send_by_mail(id, email, subject, type = Facturama::InvoiceType::ISSUED_LITE)
        response = post(nil, "cfdi?cfdiType=#{type}&cfdiId=#{id}&email=#{email}&subject=#{subject}")
        !!response['success']
      end
    end
  end
end
